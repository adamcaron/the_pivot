require 'rails_helper'

before :each do
  create_listings
  create_locations

  visit root_path
  select('Asia', from: 'Location')
  page.execute_script %Q{ $('#from').trigger("focus") } # activate datetime picker
  page.execute_script %Q{ $("a.ui-state-default:contains('15')").trigger("click") } # click on day 15click_on 'Search'
  page.execute_script %Q{ $('#to').trigger("focus") } # activate datetime picker
  page.execute_script %Q{ $("a.ui-state-default:contains('16')").trigger("click") } # click on day 15click_on 'Search'
  click_button 'Search'

  click_link 'Tiki Hut 2'

  click_button 'Add to Cart'
end

feature 'User checks out' do
  scenario 'unregistered user' do
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

  scenario 'registered user, not logged in' do
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

  scenario 'registered user, already logged in' do
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
