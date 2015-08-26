class CreateCustomRefence < ActiveRecord::Migration
  def change
    remove_column :listings, :host_id
    add_reference :listings, :host, references: :users
  end
end
