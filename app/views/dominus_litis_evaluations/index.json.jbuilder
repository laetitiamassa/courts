json.array!(@dominus_litis_evaluations) do |dominus_litis_evaluation|
  json.extract! dominus_litis_evaluation, :id, :user_id, :court_id, :evaluation, :comment
  json.url dominus_litis_evaluation_url(dominus_litis_evaluation, format: :json)
end
