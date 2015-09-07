require 'rails_helper'

feature 'User checks out' do
  before :each do
    location = Location.create!(continent: 'Africa')
    Listing.create!(name: 'testing hut', location_id: location.id, cost: 99)
    Listing.create!(name: 'testing hut2', location_id: location.id, cost: 129)

    visit root_path
    select('Africa', from: 'location')
    fill_in 'from', with: '09/24/2015'
    fill_in 'to', with: '09/30/2015'

    click_button 'Search'

    within(page.first('div#whole-card')) do
      title = find('h3')
      expect(title.text).to eq('testing hut')

      click_link("View Listing")
    end
  end

  xscenario 'unregistered user' do
    expect(current_path).to eq(cart_path)
    click_button 'Checkout'
    expect(current_path).to eq(login_path)

    click_button 'Create Account'

    expect(current_path).to eq(user_new_path)

    expect(page).to have_content('Register')

    fill_in 'Username', with: "dave"
    fill_in 'Password', with: "password"

    click_button 'Create Account'

    visit cart_path

    click_button 'Checkout'

    expect(current_path).to eq(reservations_path)
    expect(page).to have_content('Reservations')

    user = User.find_by(username: 'dave')

    expect(user.orders.count).to eq(1)
  end

  xscenario 'registered user, not logged in' do
    user = User.create(username: 'dave', password: 'password')

    expect(current_path).to eq(cart_path)
    click_button 'Checkout'
    expect(current_path).to eq(login_path)

    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password

    click_button 'Login'

    visit cart_path

    expect(click_button 'Checkout').to change(Reservation, :count).by(1)

    expect(current_path).to eq(reservations_path)
    expect(page).to have_content('Reservations')
  end

  xscenario 'registered user, already logged in' do
    user = User.create(username: 'dave', password: 'password')
    visit login_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Login'

    visit cart_path

    expect(click_button 'Checkout').to change(Reservation, :count).by(1)

    expect(current_path).to eq(reservations_path)
    expect(page).to have_content('Reservations')
  end
end
