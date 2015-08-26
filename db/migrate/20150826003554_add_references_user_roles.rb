class AddReferencesUserRoles < ActiveRecord::Migration
  def change
    rename_column :user_roles, :user_id, :user
    rename_column :user_roles, :role_id, :role
    add_reference :user_roles, :user,     index: true
    add_reference :user_roles, :role,     index: true
  end
end
