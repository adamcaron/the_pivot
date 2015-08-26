require 'rails_helper'

RSpec.describe Listing, type: :model do

  context '#listings' do
    it 'has a name' do
      listing = create_listing

      expect(listing.name).to eq("Machu Picchu")
    end

    it 'has an listing cost' do
      listing = create_listing
      expect(listing.listing_cost).to eq(5000.00)
    end

    it 'has an total cost' do
      listing = create_listing
      expect(listing.listing_cost).to eq(5000.00)
    end

    it 'has an destination continent' do
      listing = create_listing
      expect(listing.destination.continent).to eq("South America")
    end

    it "does not create an listing with name missing" do
      destination = Destination.create(continent: "South America", description: "South American description")
      listing = Listing.create(destination_id: destination.id, listing_cost: 5000.00, total_cost: 5000.00 )

      expect(Listing.all.count).to eq(0)
    end

    it "does not create an listing with listing cost missing" do
      destination = Destination.create(continent: "South America", description: "South American description")
      listing = Listing.create(destination_id: destination.id, name: "Machu Picchu", total_cost: 5000.00 )

      expect(Listing.all.count).to eq(0)
    end

    it "does not create a listing with too long of a name" do
      destination = Destination.create(continent: "South America", description: "South American description")
      listing = Listing.create(destination_id: destination.id,
                         name: "Machu PicchuUUUUELIELIaseraweraweraewLILIELILIIE", listing_cost: 5000.00 )

      expect(Listing.all.count).to eq(0)
    end


  end

  def create_listing
    destination = Destination.create(continent: "South America", description: "South American description")
    Listing.create(destination_id: destination.id, name: "Machu Picchu", listing_cost: 5000.00, total_cost: 5000.00 )
  end


end
