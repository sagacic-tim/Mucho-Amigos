json.status "success"
json.message "Logged in successfully."
json.data do
  json.user MuchoAmigoSerializer.new(resource).serializable_hash[:data][:attributes]
end