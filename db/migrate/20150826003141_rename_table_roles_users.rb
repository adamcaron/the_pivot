class RenameTableRolesUsers < ActiveRecord::Migration
  def change
    rename_table :roles_users, :user_roles
  end
end
