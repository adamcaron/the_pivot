class RemoveHousingTypeFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :housing_type
  end
end
