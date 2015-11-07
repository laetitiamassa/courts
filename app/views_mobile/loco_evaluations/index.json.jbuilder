json.array!(@loco_evaluations) do |loco_evaluation|
  json.extract! loco_evaluation, :id, :user_id, :court_id, :evaluation, :comment
  json.url loco_evaluation_url(loco_evaluation, format: :json)
end
