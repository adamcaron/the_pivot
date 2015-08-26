class RemoveHostIdListings < ActiveRecord::Migration
  def change
    remove_column :listings, :host_id
  end
end
