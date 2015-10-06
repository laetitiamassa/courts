class CreateLocoEvaluations < ActiveRecord::Migration
  def change
    create_table :loco_evaluations do |t|
      t.integer :user_id
      t.integer :court_id
      t.string :evaluation
      t.text :comment

      t.timestamps null: false
    end
  end
end
