class AddConfirmationElementsToCourt < ActiveRecord::Migration
  def change
    add_column :courts, :to_confirm, :boolean
    add_column :courts, :infirmed, :boolean
    add_column :courts, :confirmed_at, :datetime
    add_column :courts, :infirmed_at, :datetime
  end
end
