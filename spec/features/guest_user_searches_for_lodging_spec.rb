require 'rails_helper'

feature 'Guest user searches for lodging' do
  scenario 'on home page, not logged in' do

    location = Location.create!(continent: 'Africa')
    listing1 = Listing.create!(name: 'testing hut', location_id: location.id, cost: 99)
    listing2 = Listing.create!(name: 'testing hut2', location_id: location.id, cost: 129)

    visit root_path
    page.select('Africa', from: 'location')
    fill_in 'from', with: '09/29/2015'
    fill_in 'to', with: '09/30/2015'
    click_button 'Search'

    expect(current_path).to eq(search_results_path)
    expect(page).to have_content('testing hut')
    expect(page).to have_content('testing hut2')
  end
end
