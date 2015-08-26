class RenameTableTripsToListings < ActiveRecord::Migration
  def change
    rename_table :trips, :listings
  end
end
