class AddConversationIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :conversation_id, :integer
  end
end
