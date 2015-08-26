require 'rails_helper'

# As a guest customer when I visit the homepage
# I should be able to log in or create an account before completing checkout.

  # visit root
  # click_link 'login'

  # expect current_path to eq login_path

# unregistered guest
  # on login page
    # click_link create accoutn
    # fill in
    # fill in

    # click_button 'Create Account'

# registered guest
  # on login page
    # fill in username with [username]
    # fill in password with [password]

    # click_button 'Login'