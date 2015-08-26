class AddColumnsToReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :date_range
    add_column    :reservations, :start_date, :date
    add_column    :reservations, :end_date,   :date
  end
end
