require 'bigdecimal'
require "email_validator"
require "phonelib"

class MuchoLocation < ApplicationRecord
  # Each location can host many parties
  has_many :mucho_parties, dependent: :destroy, foreign_key: 'party_location_id'

  before_save :normalize_location_phone
  before_save :validate_address_with_smartystreets

  validates :location_name, uniqueness: { 
    scope: [:location_street_number, :location_street_name, :location_city, :location_postal_code], 
    message: "a location at this address already exists" 
  }, unless: :skip_uniqueness_validation?
  validates :location_description, presence: true, length: { maximum: 4096 }
  validates :location_email, email: {mode: :strict, require_fqdn: true}, allow_blank: true, allow_nil: true
  validates :location_phone, presence: true
  validates :location_available, presence: true, inclusion: [true, false], allow_blank: true

  serialize :original_attributes
  serialize :verification_info

  private

  def skip_uniqueness_validation?
    location_name.blank? || location_street_number.blank? || location_street_name.blank? || location_city.blank? || location_postal_code.blank?
  end

  def normalize_location_phone
    self.location_phone = Phonelib.parse(location_phone).full_e164.presence
  end

  def validate_address_with_smartystreets
    raw_address = "#{self.location_street_number} #{self.location_street_name} #{self.location_street_suffix}, #{self.location_city}, #{self.location_state_abbreviation} #{self.location_postal_code}, #{self.location_country_code}"
    # Call SmartyStreets API to validate the address
    app_auth_id = Rails.application.credentials.dig(:smarty_streets, :auth_id)
    app_auth_token = Rails.application.credentials.dig(:smarty_streets, :auth_token)
    credentials = SmartyStreets::StaticCredentials.new(app_auth_id, app_auth_token)
    client = SmartyStreets::ClientBuilder.new(credentials).build_us_street_api_client
    lookup = SmartyStreets::USStreet::Lookup.new(raw_address) # Pass the address string as an argument
    lookup.match = :strict # Indicates an exact address match.

    begin
        client.send_lookup(lookup)
        rescue SmartyStreets::SmartyError => err
        puts err
        return
    end

    result = lookup.result

    if result.empty?
        puts 'No candidates. This means the address is not valid.\n\n'
        return
    end

    first_candidate = result[0]


    self.location_address = "#{first_candidate.components.primary_number} #{first_candidate.components.street_name} #{first_candidate.components.street_suffix}, #{first_candidate.components.city_name}, #{first_candidate.components.state_abbreviation} #{first_candidate.components.zipcode}, US"
    self.location_street_number = first_candidate.components.primary_number
    self.location_street_name = first_candidate.components.street_name
    self.location_street_suffix = first_candidate.components.street_suffix
    self.location_city = first_candidate.components.city_name
    self.location_state_abbreviation = first_candidate.components.state_abbreviation
    self.location_country_code = "US"
    self.location_postal_code = first_candidate.components.zipcode
    self.location_latitude = "#{first_candidate.metadata.latitude}"
    self.location_longitude = "#{first_candidate.metadata.longitude}"
  end
end