json.array!(@documentations) do |documentation|
  json.extract! documentation, :id, :name, :user_id, :court_id
  json.url documentation_url(documentation, format: :json)
end
