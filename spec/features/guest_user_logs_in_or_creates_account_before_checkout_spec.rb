require 'rails_helper'

feature 'User checks out' do
  describe 'and views listings' do

    before :each do
      location = Location.create!(continent: 'Africa')
      listing1 = Listing.create!(name: 'testing hut', location_id: location.id, cost: 99)
      listing2 = Listing.create!(name: 'testing hut2', location_id: location.id, cost: 129)
      role = Role.create!(title: "registered_user")
      user = User.create!(username: 'benji', password: 'password')
      user.roles << role

      visit root_path
      page.select('Africa', from: 'location')
      fill_in 'check_in',   with: '09/29/2015'
      fill_in 'check_out',  with: '09/30/2015'
      click_button 'Search'

      expect(current_path).to eq(search_results_path)

      within(page.first('div.whole-card')) do
      title = find('h3')
      expect(title.text).to eq('testing hut')

      click_link("View Listing")
      end
    end

    xscenario 'unregistered user' do
      expect(page).to have_content('testing hut')
      click_button("Book Listing")
      click_link('Submit Payment')
      expect(current_path).to eq(login_path)

      click_link('Register')

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content('Register')

      fill_in 'Username', with: "johnny"
      fill_in 'Password', with: "password"

      click_button 'Create User'
      click_link('Submit Payment')

      expect(current_path).to eq(reservations_path)
      expect(page).to have_content('Reservation was successfully placed!')

      user = User.find_by(username: 'johnny')
      expect(user.reservations.count).to eq(1)
    end

    xscenario 'as a registered user, not logged in' do
      expect(page).to have_content('testing hut')
      click_button("Book Listing")
      click_link('Submit Payment')
      expect(current_path).to eq(login_path)

      fill_in 'Username', with: "benji"
      fill_in 'Password', with: "password"

      click_button 'Login'
      click_link('Submit Payment')

      expect(current_path).to eq(reservations_path)
      expect(page).to have_content('Reservation was successfully placed!')

      user = User.find_by(username: 'benji')
      expect(user.reservations.count).to eq(1)
    end

    scenario 'registered user, already logged in' do
      user = User.create(username: 'dave', password: 'password')
      user.roles << Role.first
      visit login_path
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_button 'Login'
      expect(current_path).to eq(root_path)


      page.select('Africa', from: 'location')
      fill_in 'check_in',   with: '09/29/2015'
      fill_in 'check_out',  with: '09/30/2015'
      click_button 'Search'
      click_link("View Listing", match: :first)
      click_button("Book Listing")

      expect(Reservation.count).to eq(0)
      click_link('Submit Payment')

      expect(Reservation.count).to eq(1)

      expect(current_path).to eq(reservations_path)
      expect(page).to have_content('Reservation was successfully placed!')
    end
  end
end
