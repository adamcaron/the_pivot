require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) { Location.new(continent: "Africa", description: "Over there") }

  it 'is valid' do
    expect(location).to be_valid
  end

  it 'is invalid without a continent' do
    location.continent = nil
    expect(location).to_not be_valid
  end

  it 'is invalid without a description' do
    location.description = nil
    expect(location).to_not be_valid
  end

  it 'has an array of trips' do
    expect(location.trips).to eq([])
  end

  it 'has an array of activities' do
    expect(location.activities).to eq([])
  end

end
