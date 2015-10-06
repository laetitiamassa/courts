class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :user_id
      t.integer :prefered_area_id

      t.timestamps null: false
    end
  end
end
