require 'rails_helper'


feature 'Guest user sees details of a lodging option' do
  before :each do
    location = Location.create!(continent: 'Africa')
    listing = Listing.create!(name: 'testing hut', location_id: location.id, cost: 99)

    visit root_path
    page.select('Africa', from: 'location')
    fill_in 'from', with: '09/29/2015'
    fill_in 'to', with: '09/30/2015'
    click_button 'Search'

    click_link 'View Listing'
  end

  scenario 'on listings#search_results view, not logged in' do
    expect(page).to have_content('testing hut')
    expect(page).to have_content('$99.00')
  end
end
