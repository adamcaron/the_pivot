class ChangeStartDateAndEndDateForReservations < ActiveRecord::Migration
  def change
    rename_column :reservations, :start_date, :check_in
    rename_column :reservations, :end_date, :check_out
  end
end
