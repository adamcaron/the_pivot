require 'rails_helper'

feature 'Business admin/host can see their listings' do
  describe 'invalid information' do

    before :each do
      user = User.create!(username: 'benji', password: 'password')
      location = Location.create!(continent: 'Africa')
      listing1 = Listing.create!(name: 'testing hut', location_id: location.id, cost: 99, host_id: user.id)
      listing2 = Listing.create!(name: 'testing hut2', location_id: location.id, cost: 129, host_id: user.id)
      role = Role.create!(title: "business_admin")
      user.roles << role
    end

    scenario 'registered admin' do
      visit root_path
      click_link("Login")
      expect(current_path).to eq(login_path)

      fill_in 'Username', with: "benji"
      fill_in 'Password', with: "password"
      click_button("Login")
      click_link_or_button("benji")
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("testing hut")
      expect(page).to have_content("testing hut2")
    end

  end
end
