class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :subject
      t.text :description
      t.string :reference
      t.integer :user_id

      t.timestamps
    end
  end
end
