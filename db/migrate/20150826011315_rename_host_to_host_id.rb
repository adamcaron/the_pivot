class RenameHostToHostId < ActiveRecord::Migration
  def change
    remove_column :listings, :host_id
    rename_column :listings, :host, :host_id
  end
end
