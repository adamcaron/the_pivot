require 'rails_helper'

feature 'Guest user sees a list of lodging options' do
  xbefore :each do
    create_locations


    visit root_path
    select('Asia', from: 'Location')
    page.execute_script %Q{ $('#from').trigger("focus") } # activate datetime picker
    page.execute_script %Q{ $("a.ui-state-default:contains('15')").trigger("click") } # click on day 15click_on 'Search'
    page.execute_script %Q{ $('#to').trigger("focus") } # activate datetime picker
    page.execute_script %Q{ $("a.ui-state-default:contains('16')").trigger("click") } # click on day 15click_on 'Search'
    click_button 'Search'
  end

  xscenario 'on listings index, not logged in' do
    expect(page).to have_content('Tiki Hut 0')
    expect(page).to have_content('Tiki Hut 1')
    expect(page).to have_content('Tiki Hut 2')
  end
end
