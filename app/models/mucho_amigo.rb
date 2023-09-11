require 'bigdecimal'
require "email_validator"
require "phonelib"

  # Each MuchoAmigo can attend many parties, through the MuchoGuest join table
  
  class MuchoAmigo < ApplicationRecord
    # Each amigo can be a guest at a party so MuchoAmigo
    # can have many guests. Since each guest can attend
    # many parties, MuchoAmigo can have many parties
    # through MuchoGuest
    has_many :mucho_guests
    has_many :mucho_parties, through: :mucho_guests, source: :mucho_party
    
    before_save :normalize_phone
    before_save :validate_address_with_smartystreets
    
    validates :full_name, presence: true, length: {minimum: 3}
    validates :email, email: {mode: :strict, require_fqdn: true}
    validates :phone, presence: true
    validates :party_animal, inclusion: [true, false]
    validates :personal_bio, presence: true
    
    serialize :original_attributes
    serialize :verification_info
    
  private

  def formatted_phone
    parsed_phone = Phonelib.parse(phone)
    return phone if parsed_phone.invalid?

    formatted =
      if parsed_phone.country_code == "1"
        parsed_phone.full_national
      else
        parsed_phone.full_international
      end
    formatted.gsub!(";", " x")
    formatted
  end

  def validate_address_with_smartystreets
    raw_address = "#{self.street_number} #{self.street_name} #{self.street_suffix}, #{self.city}, #{self.state_abbreviation} #{self.postal_code}, #{self.country_code}"
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


    self.address = "#{first_candidate.components.primary_number} #{first_candidate.components.street_name} #{first_candidate.components.street_suffix}, #{first_candidate.components.city_name}, #{first_candidate.components.state_abbreviation} #{first_candidate.components.zipcode}, US"
    self.street_number = first_candidate.components.primary_number
    self.street_name = first_candidate.components.street_name
    self.street_suffix = first_candidate.components.street_suffix
    self.city = first_candidate.components.city_name
    self.state_abbreviation = first_candidate.components.state_abbreviation
    self.country_code = "US"
    self.postal_code = first_candidate.components.zipcode
    self.latitude = "#{first_candidate.metadata.latitude}"
    self.longitude = "#{first_candidate.metadata.longitude}"
  end

  def normalize_phone
    self.phone = Phonelib.parse(phone).full_e164.presence
  end
end