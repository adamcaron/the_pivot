class AddReferencesHousingTypeToListings < ActiveRecord::Migration
  def change
    rename_column :listings, :housing_type_id, :housing_type
    add_reference :listings, :housing_type, index: true
  end
end
