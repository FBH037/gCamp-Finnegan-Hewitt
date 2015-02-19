require 'rails_helper'
describe 'user can CRUD User' do
  scenario 'user can create User' do
    visit '/users'
    click_on "New User"
    fill_in 'First name', :with => 'joe'
    fill_in 'Last name', :with => 'bartlett'
    fill_in 'Email', :with => 'jb@green.com'
    click_on 'Create User'
    expect(page).to have_content('joe bartlett')
  end
  scenario 'user can view a show page for a User' do
    User.create(first_name: 'joe', last_name: 'bartlett', email: 'jb@green.com')
    visit '/users'
    expect(page).to have_content('joe bartlett')
  end
  scenario 'user can update a User'
    User.create(first_name: 'joe', last_name: 'bartlett', email: 'jb@green.com')
    visit '/users'
    click_on 'Edit'


end
