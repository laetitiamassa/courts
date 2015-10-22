ActiveAdmin.register User do

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

permit_params :email, :first_name, :last_name, :bar, 
                                  :street, :street_number, :city, :zipcode, 
                                  :telephone, :fax, :mobile, :website, :facebook, :twitter, :linkedin,
                                  :dominus_litis, :loco, :subscribed, :extended_trial, :extended_trial_end_date, 
                                  :presentation, :avatar,
                                  :plan, :plan_start_date, :plan_end_date, :subscription_start_date, :subscription_id


end
