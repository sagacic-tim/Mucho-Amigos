json.data do 
  json.array!(@mucho_guests) do |honored_guest|
      json.partial! "guest", guest: honored_guest
  end
end