class CreateTableHousingType < ActiveRecord::Migration
  def change
    create_table :housing_types do |t|
      t.string 'name'
    end
  end
end
