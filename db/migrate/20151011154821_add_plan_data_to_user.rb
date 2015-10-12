class AddPlanDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :plan, :string
    add_column :users, :plan_start_date, :datetime
    add_column :users, :plan_end_date, :datetime
  end
end
