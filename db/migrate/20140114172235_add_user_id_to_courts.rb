class AddUserIdToCourts < ActiveRecord::Migration
  def change
    add_column :courts, :user_id, :integer
    add_index :courts, :user_id
  end
end
