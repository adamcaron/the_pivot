class ChangeDestinationToLocations < ActiveRecord::Migration
  def change
    rename_table  :locations, :locations
    remove_column :locations,    :description
    remove_column :locations,    :image_url
  end
end
