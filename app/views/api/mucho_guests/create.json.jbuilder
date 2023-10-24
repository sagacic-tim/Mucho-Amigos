# All we are doing is create a single mucho_party with a single host.

json.partial! 'guest', guest: @mucho_guest
json.message "Guest successfully added to Party"