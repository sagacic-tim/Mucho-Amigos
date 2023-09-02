# All we are doing is create a single mucho_party with a single host.

json.partial! 'location', party: @mucho_location
json.message "Location successfully created"