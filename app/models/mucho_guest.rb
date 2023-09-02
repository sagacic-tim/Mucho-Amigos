class MuchoGuest < ApplicationRecord

  # MuchoGuest acts as a join model between MuchoAmigo and MuchoParty
  belongs_to :amigo, class_name: 'MuchoAmigo', foreign_key: 'amigo_id'
  belongs_to :party, class_name: 'MuchoParty', foreign_key: 'party_id'

  # Enforce presence and uniqueness constraint
  validates :amigo_id, presence: true, uniqueness: { scope: :party_id, message: lambda { |record, _attrs|
    "The guest '#{record.amigo_name}' has already been added to the guest list for this party"
  }}, unless: :skip_uniqueness_validation?

  # Custom validation for uniqueness with a custom message
  # validate :custom_uniqueness_message, if: :amigo_and_party_present?
  
  def amigo_name # provide mucho_amigos full_name to error mesaagges
    MuchoAmigo.find_by(id: amigo_id)&.full_name || 'Unknown'
  end

  private

  def skip_uniqueness_validation?
    !MuchoAmigo.exists?(id: amigo_id) || !MuchoParty.exists?(id: party_id)
  end
end