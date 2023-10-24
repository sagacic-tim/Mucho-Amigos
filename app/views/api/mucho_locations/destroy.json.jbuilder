# All we are doing is create a single mucho_amigos record.

json.partial! 'location', location: @mucho_location
json.message "Locaition successfully removed"