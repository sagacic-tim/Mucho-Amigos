# This view is used to respond after a
# user updates their password.

if @mucho_amigo.errors.empty?
  json.partial! 'amigo', amigo: @mucho_amigo
  json.message "Password updated successfully."
else
  json.errors @mucho_amigo.errors.full_messages, status: :unprocessable_entity
end