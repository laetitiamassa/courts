class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :subject
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
