json.array!(@housings) do |housing|
  json.extract! housing, :id, :available, :number_of_bedrooms, :number_of_bathrooms
  json.url housing_url(housing, format: :json)
end
