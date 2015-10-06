json.array!(@skills) do |skill|
  json.extract! skill, :id, :user_id, :prefered_area_id
  json.url skill_url(skill, format: :json)
end
