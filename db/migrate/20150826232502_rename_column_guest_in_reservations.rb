class RenameColumnGuestInReservations < ActiveRecord::Migration
  def change
    rename_column :reservations, :guest_id, :user_id
  end
end
