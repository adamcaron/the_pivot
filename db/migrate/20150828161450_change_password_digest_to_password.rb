class ChangePasswordDigestToPassword < ActiveRecord::Migration
  def change
    rename_column :listings, :password_digest, :password
  end
end
