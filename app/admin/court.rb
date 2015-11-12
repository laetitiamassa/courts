ActiveAdmin.register Court do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

permit_params :performance, :jurisdiction, :date, :bar, :have_found, :details, :is_external, :external_requester_first_name, :external_requester_last_name, :external_requester_email, :internalized_at, :user_id


end
