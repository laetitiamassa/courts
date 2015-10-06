class AddAttachmentDocumentToDocumentations < ActiveRecord::Migration
  def self.up
    change_table :documentations do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :documentations, :document
  end
end
