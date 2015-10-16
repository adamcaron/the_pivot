require 'rails_helper'

feature 'Guest user can not log in with invalid information' do
  describe 'invalid information' do

    scenario 'unregistered user' do
      visit root_path
      click_link("Register")
      expect(current_path).to eq(new_user_path)

      fill_in 'Username', with: "johnny"
      fill_in 'Password', with: ""
      click_link_or_button("Create User")
      expect(page).to have_content("Invalid input - Please try creating user again")
    end

  end
end
