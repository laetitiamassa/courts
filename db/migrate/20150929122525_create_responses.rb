class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.boolean :content
      t.integer :user_id
      t.integer :court_id

      t.timestamps null: false
    end
  end
end
