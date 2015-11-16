class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.integer :court_id
      t.integer :user_id
      t.boolean :confirmed
      t.boolean :infirmed

      t.timestamps null: false
    end
  end
end
