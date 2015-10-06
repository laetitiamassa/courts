class DropConversation < ActiveRecord::Migration
  def self.up
  	drop_table :conversation
  end
end
