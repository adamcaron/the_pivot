require 'rails_helper'


feature 'Guest user sees details of a lodging option' do
  before :each do
    create_locations


    visit root_path
    select('Asia', from: 'Location')
    page.execute_script %Q{ $('#from').trigger("focus") } # activate datetime picker
    page.execute_script %Q{ $("a.ui-state-default:contains('15')").trigger("click") } # click on day 15click_on 'Search'
    page.execute_script %Q{ $('#to').trigger("focus") } # activate datetime picker
    page.execute_script %Q{ $("a.ui-state-default:contains('16')").trigger("click") } # click on day 15click_on 'Search'
    click_button 'Search'

    click_link 'Tiki Hut 2'
  end

  scenario 'on listing show, not logged in' do
    expect(current_path).to eq('tiki-hut-2')
    expect(page).to have_content('Tiki Hut 2')
    expect(page).to have_content('$100.00')
    expect(page).to have_content('15')
    expect(page).to have_content('16')
  end
end
