class CreateLocos < ActiveRecord::Migration
  def change
    create_table :locos do |t|
      t.integer :user_id
      t.integer :court_id

      t.timestamps null: false
    end
  end
end
