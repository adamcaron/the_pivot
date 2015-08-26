class AddForeignKeyForHostToListings < ActiveRecord::Migration
  def change
    add_foreign_key :listings, :users, column: :host
  end
end
