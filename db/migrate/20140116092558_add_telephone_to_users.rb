class AddTelephoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :telephone, :integer
  end
end
