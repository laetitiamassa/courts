class AddLocoIdToPrivateDocumentations < ActiveRecord::Migration
  def change
    add_column :private_documentations, :loco_id, :integer
  end
end
