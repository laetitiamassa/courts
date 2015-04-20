class AddExtendedTrialAndExtendedTrialEndDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :extended_trial, :boolean
    add_column :users, :extended_trial_end_date, :datetime
  end
end
