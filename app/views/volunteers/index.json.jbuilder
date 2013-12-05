json.array!(@volunteers) do |volunteer|
  json.extract! volunteer, :id, :first_name, :last_name, :street, :city, :state, :zip, :zip, :primary_phone, :secondary_phone, :email
  json.url volunteer_url(volunteer, format: :json)
end
