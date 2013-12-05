json.array!(@work_days) do |work_day|
  json.extract! work_day, :id, :time
  json.url work_day_url(work_day, format: :json)
end
