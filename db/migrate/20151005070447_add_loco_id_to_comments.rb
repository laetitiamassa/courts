class AddLocoIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :loco_id, :integer
  end
end
