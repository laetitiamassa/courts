class CreatePrivateDocumentations < ActiveRecord::Migration
  def change
    create_table :private_documentations do |t|
      t.string :name
      t.integer :user_id
      t.integer :conversation_id

      t.timestamps null: false
    end
  end
end
