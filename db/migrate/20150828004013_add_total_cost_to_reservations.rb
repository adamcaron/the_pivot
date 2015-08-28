class AddTotalCostToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :total_cost, :float
  end
end
