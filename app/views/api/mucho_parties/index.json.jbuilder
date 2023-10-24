json.data do 
  json.array!(@mucho_parties) do |incredible_party|
    puts "Incredible Party: #{incredible_party.inspect}"
      json.partial! "party", party: incredible_party
  end
end