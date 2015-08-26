class AddReferenceListings < ActiveRecord::Migration
  def change
    add_reference :listings, :host, references: :users
  end
end
