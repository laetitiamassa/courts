json.array!(@prefered_areas) do |prefered_area|
  json.extract! prefered_area, :id, :name
  json.url prefered_area_url(prefered_area, format: :json)
end
