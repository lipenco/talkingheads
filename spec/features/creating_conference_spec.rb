require 'spec_helper'
feature 'Creating Conferences' do
  scenario "can create a conference" do
    visit '/'
    click_link 'New Conference'
    fill_in 'Name', with: 'TextMate 2'
    fill_in 'Tags', with: 'RoR'
    fill_in 'Date', with: '20/01/1014'
    fill_in 'Organizer', with: 'Rails Girls'
    fill_in 'Place', with: 'Warsaw'
    fill_in 'Description', with: 'A text-editor for OS X'
    click_button 'Create Conference'
    expect(page).to have_content('Conference has been created.')
  end
end