class MuchoParty < ApplicationRecord
  # Parties are related to a party_location_id which is a foreign
  # key to MuchoLocation
  belongs_to :party_location, class_name: 'MuchoLocation', foreign_key: 'party_location_id', optional: false
  # Parties are related to a party_host_id which is a foreign key
  # to MuchoAmigo.
  belongs_to :mucho_amigo, class_name: 'MuchoAmigo', foreign_key: 'party_host_id'
  # Each party can have many guests
  # Explicitly specify the foreign key here
  has_many :mucho_guests, foreign_key: 'party_id' 
  # Each MuchoParty can have many attendees (MuchoAmigos),
  # through the MuchoGuest join table
  has_many :mucho_amigos, through: :mucho_guests, source: :mucho_amigo

  # Ensure no duplicate party names at the same date and time
  validates :party_name, uniqueness: { 
    scope: [:party_date, :party_time], 
    message: "cannot have duplicate party names at the same date and time" 
  }, unless: :skip_uniqueness_validation?

  public

  def as_json(options={})
    super(options).tap do |json|
      if json['party_time'].present?
        parsed_time = Time.parse(json['party_time'])
        json['party_time'] = parsed_time.strftime('%H:%M:%S')
      end
    end
  end

  private

  def skip_uniqueness_validation?
    party_name.blank? || party_date.blank? || party_time.blank? || !date_and_time_valid?
  end

  def date_and_time_valid?
    begin
      Date.parse(party_date.to_s)
      Time.parse(party_time.to_s)
      true
    rescue ArgumentError
      false
    end
  end
end
