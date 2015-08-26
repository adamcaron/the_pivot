class RenameTableOrdersToListings < ActiveRecord::Migration
  def change
    rename_table :orders, :reservations
  end
end
