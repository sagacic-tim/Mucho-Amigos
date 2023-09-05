class MuchoLocation < ApplicationRecord
  # Each location can host many parties
  has_many :mucho_parties, dependent: :destroy


  validates :location_name, uniqueness: { 
    scope: [:location_street_number, :location_street_name, :location_city, :location_postal_code], 
    message: "a location at this address already exists" 
  }, unless: :skip_uniqueness_validation?

  private

  def skip_uniqueness_validation?
    location_name.blank? || location_street_number.blank? || location_street_name.blank? || location_city.blank? || location_postal_code.blank?
  end
end