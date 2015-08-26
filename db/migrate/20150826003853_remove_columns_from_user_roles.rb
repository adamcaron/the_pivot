class RemoveColumnsFromUserRoles < ActiveRecord::Migration
  def change
    remove_column :user_roles, :user
    remove_column :user_roles, :role
  end
end
