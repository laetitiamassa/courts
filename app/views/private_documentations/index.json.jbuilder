json.array!(@private_documentations) do |private_documentation|
  json.extract! private_documentation, :id, :name, :user_id, :conversation_id
  json.url private_documentation_url(private_documentation, format: :json)
end
