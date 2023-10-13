# All we are doing is displaying a single mucho_amigos partial.

if @mucho_amigo
  json.partial! 'amigo', amigo: @mucho_amigo
else
  json.message "Amigo not found", status: :not_found
end
