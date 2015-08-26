class ChangeDestinationToLocations < ActiveRecord::Migration
  def change
    rename_table  :destinations, :locations
    remove_column :locations,    :description
    remove_column :locations,    :image_url
  end
end
