require 'rails_helper'

feature 'Guest user sees a list of lodging options' do
  before :each do
    location = Location.create!(continent: 'Africa')
    Listing.create!(name: 'Tiki Hut 0', location_id: location.id, cost: 19)
    Listing.create!(name: 'Tiki Hut 1', location_id: location.id, cost: 29)
    Listing.create!(name: 'Tiki Hut 2', location_id: location.id, cost: 39)

    visit root_path
    page.select('Africa', from: 'location')
    fill_in 'from', with: '09/29/2015'
    fill_in 'to', with: '09/30/2015'
    click_button 'Search'

  end

  scenario 'on listings index, not logged in' do
    expect(current_path).to eq(search_results_path)
    expect(page).to have_content('Tiki Hut 0')
    expect(page).to have_content('Tiki Hut 1')
    expect(page).to have_content('Tiki Hut 2')
  end
end
