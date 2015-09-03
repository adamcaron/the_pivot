require 'rails_helper'

describe 'Registered user creates a business', type: :feature do
  xit 'sees host button' do
    user = User.create(username: 'dave', password: 'password')

    visit login_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password

    click_button 'Login'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Host Your Space')
  end
end
