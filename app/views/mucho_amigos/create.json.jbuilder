# All we are doing is create a single mucho_amigos record.

json.partial! 'amigo', amigo: @mucho_amigo
json.message "Amigo successfully created"