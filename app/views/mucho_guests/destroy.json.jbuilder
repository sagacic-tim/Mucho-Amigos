# All we are doing is create a single mucho_amigos record.

json.partial! 'guest', guest: @mucho_guest
json.message "Guest successfully removed from Party"