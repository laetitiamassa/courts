json.array!(@confirmations) do |confirmation|
  json.extract! confirmation, :id, :court_id, :user_id, :confirmed, :infirmed
  json.url confirmation_url(confirmation, format: :json)
end
