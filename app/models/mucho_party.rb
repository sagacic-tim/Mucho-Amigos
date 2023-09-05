class MuchoParty < ApplicationRecord
  # Each MuchoParty can have many attendees (MuchoAmigos), through the MuchoGuest join table
  has_many :mucho_guests, dependent: :destroy
  has_many :mucho_amigos, through: :mucho_guests
  
  # Parties are related to location via MuchoLocations
  belongs_to :party_location, class_name: 'MuchoLocation', optional: false

  # If MuchoParty is also related to MuchoAmigo as the 'host'
  belongs_to :party_host, class_name: 'MuchoAmigo', optional: false

  # Ensure no duplicate party names at the same date and time
  validates :party_name, uniqueness: { 
    scope: [:party_date, :party_time], 
    message: "cannot have duplicate party names at the same date and time" 
  }, unless: :skip_uniqueness_validation?

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

  def as_json(options={})
    super(options).tap do |json|
      if json['party_time'].present?
        json['party_time'] = json['party_time'].strftime('%H:%M:%S')
      end
    end
  end
end
