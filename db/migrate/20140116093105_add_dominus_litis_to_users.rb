class AddDominusLitisToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dominus_litis, :boolean
  end
end
