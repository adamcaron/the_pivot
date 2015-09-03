require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) { Location.new(continent: "Africa") }

  it 'is valid' do
    expect(location).to be_valid
  end

  it 'is invalid without a continent' do
    location.continent = nil
    expect(location).to_not be_valid
  end
end
