class DropConversations < ActiveRecord::Migration
  def self.up
  	drop_table :conversations
  end
end
