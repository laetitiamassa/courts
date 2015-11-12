class AddExternalCourtAttributesToCourt < ActiveRecord::Migration
  def change
    add_column :courts, :is_external, :boolean
    add_column :courts, :external_requester_first_name, :string
    add_column :courts, :external_requester_last_name, :string
    add_column :courts, :external_requester_email, :string
  end
end
