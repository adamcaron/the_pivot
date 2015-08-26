class RemoveHostFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :host_id
    add_column    :listings, :host,     :integer
    add_reference :listings, :host, references: :users
  end
end
