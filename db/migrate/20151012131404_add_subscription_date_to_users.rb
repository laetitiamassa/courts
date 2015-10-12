class AddSubscriptionDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscription_start_date, :datetime
  end
end
