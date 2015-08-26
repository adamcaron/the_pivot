class DropExtraneousTables < ActiveRecord::Migration
  def change
    drop_table :activities
    drop_table :order_trips
    drop_table :reviews
  end
end
