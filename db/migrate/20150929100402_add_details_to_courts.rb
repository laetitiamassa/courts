class AddDetailsToCourts < ActiveRecord::Migration
  def change
    add_column :courts, :details, :text
  end
end
