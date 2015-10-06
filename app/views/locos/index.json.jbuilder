json.array!(@locos) do |loco|
  json.extract! loco, :id, :user_id, :court_id
  json.url loco_url(loco, format: :json)
end
