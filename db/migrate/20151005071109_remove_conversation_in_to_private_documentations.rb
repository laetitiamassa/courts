class RemoveConversationInToPrivateDocumentations < ActiveRecord::Migration
  def change
  	remove_column :private_documentations, :conversation_id
  end
end
