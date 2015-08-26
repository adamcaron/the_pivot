require 'rails_helper'

before :each do
  3.times do |i|
    business_admin = User.create!(username: "business_admin_#{i}", password_digest: 'password')
    business_admin.update!(host_id: business_admin.id)
    Listing.create!(location_id:          4,
                    cost:                 100.00,
                    name:                 "Tiki Hut #{i}",
                    image_file_name:      "",
                    image_content_type:   "",
                    image_file_size:      nil,
                    image_updated_at:     nil,
                    gmaps:                nil,
                    lat:                  nil,
                    long:                 nil,
                    number_of_guests:     nil,
                    host_id:              business_admin.id)
  end

  visit root_path
  select('Asia', from: 'Location')
  page.execute_script %Q{ $('#from').trigger("focus") } # activate datetime picker
  page.execute_script %Q{ $("a.ui-state-default:contains('15')").trigger("click") } # click on day 15click_on 'Search'
  page.execute_script %Q{ $('#to').trigger("focus") } # activate datetime picker
  page.execute_script %Q{ $("a.ui-state-default:contains('16')").trigger("click") } # click on day 15click_on 'Search'
  click_button 'Search'
end

feature 'Guest user sees a list of lodging options' do
  scenario 'on listings index, not logged in' do
    expect(page).to have_content('Tiki Hut 0')
    expect(page).to have_content('Tiki Hut 1')
    expect(page).to have_content('Tiki Hut 2')
  end
end
