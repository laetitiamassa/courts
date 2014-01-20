class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.string :performance
      t.string :jurisdiction
      t.datetime :date
      t.string :bar
      t.boolean :have_found

      t.timestamps
    end
  end
end
