json.array!(@jobs) do |job|
  json.extract! job, :id, :title
  json.url job_url(job, format: :json)
end
