class AddRemoveColumnsReservations < ActiveRecord::Migration
  def change
    rename_column :reservations, :user_id, :guest_id
    add_reference :reservations, :listing, index: true
    add_column    :reservations, :date_range, :string
  end
end
