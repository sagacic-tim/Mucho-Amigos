# All we are doing is create a single mucho_amigos record.

if @mucho_amigo.destroyed?
  json.message "Amigo deleted successfully."
else
  json.errors @mucho_amigo.errors.full_messages, status: :unprocessable_entity
end