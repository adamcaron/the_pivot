class ChangeNumberOfGuestsToNumberOfDaysForListings < ActiveRecord::Migration
  def change
    rename_column :listings, :number_of_guests, :number_of_days
  end
end
