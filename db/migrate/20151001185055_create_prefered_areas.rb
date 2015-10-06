class CreatePreferedAreas < ActiveRecord::Migration
  def change
    create_table :prefered_areas do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
