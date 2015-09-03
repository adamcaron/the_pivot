require 'rails_helper'

RSpec.describe Listing, type: :model do
  let(:location) {Location.create!(continent: "South America")}
  let(:listing)  {Listing.create!(location_id: location.id,
                                  name: "Machu Picchu",
                                  cost: 5000.00 )
}

  context '#listings' do
    it 'has a name' do
      expect(listing.name).to eq("Machu Picchu")
    end

    it 'has a cost' do
      expect(listing.cost).to eq(5000.00)
    end

    it "does not create a listing with name missing" do
      Listing.create(location_id: location.id, cost: 5000.00)
      expect(Listing.all.count).to eq(0)
    end

    it "does not create an listing with cost missing" do
      Listing.create(location_id: location.id, name: "Machu Picchu")
      expect(Listing.all.count).to eq(0)
    end

    it "does not create a listing with too long of a name" do
      Listing.create(location_id: location.id, cost: 5000.00, name: "Machu PicchuUUUUELIELIaseraweraweraewLILIELILIIE")
      expect(Listing.all.count).to eq(0)
    end
  end
end
