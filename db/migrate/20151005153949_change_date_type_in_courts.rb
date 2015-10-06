class ChangeDateTypeInCourts < ActiveRecord::Migration

  def up
    change_column :courts, :date, :string
  end

  def down
    change_column :courts, :date, :datetime
  end
end
