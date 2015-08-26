class RemoveColumnHousingTypeIdFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :housing_type_id
  end
end
