# All we are doing is create a single mucho_parties record.

json.partial! 'party', party: @mucho_party
json.message "Party, date, and/or time and/or location and/or host successfully updated!"