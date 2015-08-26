class AddReferenceHousingTypeListings < ActiveRecord::Migration
  def change
    add_reference :listings, :housing_type, index: true
  end
end
