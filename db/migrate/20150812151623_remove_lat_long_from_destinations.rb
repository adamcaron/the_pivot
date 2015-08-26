class RemoveLatLongFromDestinations < ActiveRecord::Migration
  def change
    remove_column :locations, :lat
    remove_column :locations, :long
  end
end
