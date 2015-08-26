class AddRemoveColumnToListings < ActiveRecord::Migration
  def change
    rename_column :listings, :destination_id, :location_id
    rename_column :listings, :trip_cost,      :cost

    remove_column :listings, :total_cost
    remove_column :listings, :activity_id
    remove_column :listings, :description

    add_column    :listings, :host_id,          :integer
    add_column    :listings, :housing_type_id,  :integer
    add_column    :listings, :number_of_guests, :integer
  end
end
