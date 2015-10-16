require 'rails_helper'

feature 'Business admin/host can see their listings' do
  describe 'invalid information' do

    before :each do
      user = User.create!(username: 'benji', password: 'password')
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

      click_link("Edit Profile")
      expect(page).to have_content("Update Profile")

      fill_in 'Username', with: "benji"
      fill_in 'New Password', with: "password1"
      click_link_or_button("Update User")
      expect(page).to have_content("Profile updated!")
    end

  end
end
