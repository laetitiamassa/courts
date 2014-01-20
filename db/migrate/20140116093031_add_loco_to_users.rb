class AddLocoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :loco, :boolean
  end
end
