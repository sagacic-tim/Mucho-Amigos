# All we are doing is create a single mucho_amigos record.

if @mucho_amigo.persisted?
  json.partial! 'amigo', amigo: @mucho_amigo
  json.message "Amigo successfully created"
else
  json.errors @mucho_amigo.errors.full_messages, status: :unprocessable_entity
end