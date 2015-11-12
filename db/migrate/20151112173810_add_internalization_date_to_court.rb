class AddInternalizationDateToCourt < ActiveRecord::Migration
  def change
    add_column :courts, :internalized_at, :datetime
  end
end
