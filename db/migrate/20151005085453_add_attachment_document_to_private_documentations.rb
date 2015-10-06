class AddAttachmentDocumentToPrivateDocumentations < ActiveRecord::Migration
  def self.up
    change_table :private_documentations do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :private_documentations, :document
  end
end
