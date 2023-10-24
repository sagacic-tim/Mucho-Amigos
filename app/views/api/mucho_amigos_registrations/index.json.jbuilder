json.data do 
  json.array!(@mucho_amigos) do |good_amigo|
      json.partial! "amigo", amigo: good_amigo
  end
end