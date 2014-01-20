class AddBarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bar, :string
  end
end
