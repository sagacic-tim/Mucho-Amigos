# All we are doing is create a single mucho_party with a single host.

json.partial! 'party', party: @mucho_party
json.message "Party with party host and location successfully created"