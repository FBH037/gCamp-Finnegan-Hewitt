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
    user = User.create(first_name: 'joe', last_name: 'bartlett', email: 'jb@green.com')
    visit "/users/#{user.id}"
    expect(page).to have_content('joe bartlett')
  end
  scenario 'user can update a User' do
    User.create(first_name: 'joe', last_name: 'bartlett', email: 'jb@green.com')
    visit '/users'
    click_on 'Edit'
    fill_in 'First name', :with => 'roe'
    fill_in 'Last name', :with => 'bart'
    fill_in 'Email', :with => 'jb@reen.com'
    click_on 'Update User'
    expect(page).to have_content('roe bart')
  end
  scenario 'user can destroy a User' do
    User.destroy_all
    user = User.create(first_name: 'joe', last_name: 'bartlett', email: 'jb@green.com')
    visit "users/#{user.id}/edit"
    click_on 'Delete'
    expect(page).to have_no_content("joe bartlett")
  end
end
