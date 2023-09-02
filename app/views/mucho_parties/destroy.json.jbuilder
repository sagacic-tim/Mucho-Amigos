# All we are doing is create a single mucho_amigos record.

json.partial! 'party', party: @mucho_party
json.message "Party successfully terminated"