class AddFaxToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fax, :integer
  end
end
