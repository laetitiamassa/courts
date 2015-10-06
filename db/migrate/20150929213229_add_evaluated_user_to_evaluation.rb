class AddEvaluatedUserToEvaluation < ActiveRecord::Migration
  def change
    add_column :evaluations, :evaluated_user, :string
  end
end
