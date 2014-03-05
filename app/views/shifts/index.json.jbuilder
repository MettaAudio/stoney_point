json.array!(@shifts) do |shift|
  json.extract! shift, :id, :time
  json.url shift_url(shift, format: :json)
end
