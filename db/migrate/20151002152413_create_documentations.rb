class CreateDocumentations < ActiveRecord::Migration
  def change
    create_table :documentations do |t|
      t.string :name
      t.integer :user_id
      t.integer :court_id

      t.timestamps null: false
    end
  end
end
