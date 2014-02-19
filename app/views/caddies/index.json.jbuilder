json.array!(@caddies) do |caddy|
  json.extract! caddy, :id, :first_name, :last_name, :phone
  json.url caddy_url(caddy, format: :json)
end
