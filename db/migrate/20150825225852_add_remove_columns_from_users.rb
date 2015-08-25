class AddRemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :role
    remove_column :users, :full_name
    remove_column :users, :address

    add_column :users, :host_id, :integer
  end
end
