# All we are doing is create a single mucho_amigos record.

json.partial! 'amigo', party: @mucho_amigos
json.message "Amigo successfully updated!"