json.array!(@artifacts) do |artifact|
  json.extract! artifact, :id, :title, :kind, :content, :user_id
  json.url artifact_url(artifact, format: :json)
end
