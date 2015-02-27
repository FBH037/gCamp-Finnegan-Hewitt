require 'rails_helper'
describe 'user can register' do
  scenario 'user can register' do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    visit '/sign-up'
    fill_in 'First name', :with => 'joe'
    fill_in 'Last name', :with => 'bartlett'
    fill_in 'Email', :with => 'jb@green.com'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign Up'
    expect(page).to have_content('joe bartlett')
    expect(page).to have_content("User was successfully created")
    expect(page).to have_content("Your life, organized.")
  end
end
