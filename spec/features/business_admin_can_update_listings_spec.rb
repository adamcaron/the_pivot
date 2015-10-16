require 'rails_helper'

feature 'Business admin/host can update their listings' do
  describe 'valid and invalid information' do

    before :each do
      user = User.create!(username: 'benji', password: 'password')
      role = Role.create!(title: "business_admin")
      user.roles << role
      location = Location.create!(continent: 'Africa')
      listing1 = Listing.create!(name: 'testing hut', location_id: location.id, cost: 99, host_id: user.id)
    end

    scenario 'registered admin updates listings with valid information' do
      visit root_path
      click_link("Login")
      expect(current_path).to eq(login_path)

      fill_in 'Username', with: "benji"
      fill_in 'Password', with: "password"
      click_button("Login")
      click_link_or_button("benji")
      expect(current_path).to eq(dashboard_path)

      click_link("Edit Listing")
      expect(page).to have_content("Listing Name")

      fill_in 'Listing Name:', with: "updated hut"
      fill_in 'Cost', with: 199
      click_link_or_button("Update Listing")
      expect(page).to have_content("Listing updated!")
    end
  end
end
