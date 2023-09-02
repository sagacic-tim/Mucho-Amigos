json.data do 
  json.array!(@mucho_locations) do |awesome_location|
      json.partial! "location", location: awesome_location
  end
end