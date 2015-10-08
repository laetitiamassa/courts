json.array!(@notifications) do |notification|
  json.extract! notification, :id, :notifier_id, :notifiee_id, :message
  json.url notification_url(notification, format: :json)
end
