require 'rails_helper'
describe 'user can register' do
  scenario 'user can register' do
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
  scenario 'user can not register without first_name' do
    visit '/sign-up'
    fill_in 'Last name', :with => 'bartlett'
    fill_in 'Email', :with => 'jb@green.com'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign Up'
    expect(page).to have_content('First name can\'t be blank')
  end

  scenario 'user can not register without a last_name' do
    visit '/sign-up'
    fill_in 'First name', :with => 'joe'
    fill_in 'Email', :with => 'jb@green.com'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign Up'
    expect(page).to have_content('Last name can\'t be blank')
  end

  scenario 'user can not register without an email' do
    visit '/sign-up'
    fill_in 'First name', :with => 'joe'
    fill_in 'Last name', :with => 'bartlett'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign Up'
    expect(page).to have_content('Email can\'t be blank')
  end
  scenario 'user can not register without an email' do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    visit '/sign-up'
    fill_in 'First name', :with => 'joe'
    fill_in 'Last name', :with => 'bartlett'
    fill_in 'Email', :with => 'fbhewitt@gmail.com'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign Up'
    expect(page).to have_content('Email has already been taken')
  end


  scenario 'user can not register without an email' do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    visit '/sign-up'
    fill_in 'First name', :with => 'joe'
    fill_in 'Last name', :with => 'bartlett'
    fill_in 'Email', :with => 'jb@green.com'
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign Up'
    expect(page).to have_content('Password can\'t be blank')
  end


end
