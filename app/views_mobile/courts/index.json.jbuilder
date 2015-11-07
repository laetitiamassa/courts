json.array!(@courts) do |court|
  json.extract! court, :id, :performance, :jurisdiction, :date, :bar, :have_found
  json.url court_url(court, format: :json)
end
