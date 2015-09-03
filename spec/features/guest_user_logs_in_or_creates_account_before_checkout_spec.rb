require 'rails_helper'

feature 'User checks out' do
  before :each do
    create_locations
    Listing.create!(name: 'testing hut', location_id: 5, cost: 99)
  end

  xscenario 'unregistered user' do #, :js => true do
    visit root_path
    page.select('Asia', from: 'location')
    fill_in 'from', with: '09/28/2015'
    fill_in 'to', with: '09/29/2015'
    click_button 'Search'

    expect(current_path).to eq(search_results_path)

    first(:link, "View Listing").click
    click_link 'Book Listing'

    save_and_open_page

    expect(current_path).to eq(cart_path)

    click_link 'Checkout'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Register')

    click_link 'Register'
    fill_in 'Username', with: "dave"
    fill_in 'Password', with: "password"
    click_link_or_button 'Create User'
    save_and_open_page
    #expect(page).to have_content('dave')

    #visit cart_path

    #click_link 'Checkout'

    #fill_in 'Username', with: "dave"
    #fill_in 'Password', with: "password"
    #click_button 'Login'

    #expect(current_path).to eq(cart_path)
    #click_link 'Checkout'

    #save_and_open_page
    #expect(current_path).to eq(reservations_path)
    #expect(page).to have_content('Reservations')

    #expect(user.orders.count).to eq(1)
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
