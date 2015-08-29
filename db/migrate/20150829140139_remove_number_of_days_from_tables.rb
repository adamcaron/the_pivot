class RemoveNumberOfDaysFromTables < ActiveRecord::Migration
  def change
    remove_column :listings, :number_of_days
  end
end
