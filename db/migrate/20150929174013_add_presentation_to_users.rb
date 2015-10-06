class AddPresentationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :presentation, :text
  end
end
