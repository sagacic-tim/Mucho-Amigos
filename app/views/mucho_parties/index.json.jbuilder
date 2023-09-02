json.data do 
  json.array!(@mucho_parties) do |incredible_party|
      json.partial! "party", guest: incredible_party
  end
end