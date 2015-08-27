class DropTableHousingTypes < ActiveRecord::Migration
  def change
    drop_table :housing_types
  end
end
