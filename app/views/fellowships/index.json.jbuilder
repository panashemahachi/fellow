json.array!(@fellowships) do |fellowship|
  json.extract! fellowship, :id
  json.url fellowship_url(fellowship, format: :json)
end
