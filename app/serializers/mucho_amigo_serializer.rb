class MuchoAmigoSerializer
  include JSONAPI::Serializer
  attributes :id, :full_name, :user_name, :email, :phone, :address, :street_number, :street_name, :street_suffix, :city, :state_abbreviation, :country_code, :postal_code, :party_animal, :personal_bio
end