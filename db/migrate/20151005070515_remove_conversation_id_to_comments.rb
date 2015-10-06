class RemoveConversationIdToComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :conversation_id
  end
end
