# All we are doing is create a single mucho_parties record.

json.partial! 'location', location: @mucho_location
json.message "Location successfully updated!"