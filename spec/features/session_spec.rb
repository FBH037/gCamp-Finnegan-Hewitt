require 'rails_helper'
  describe 'user can create and destroy a session' do
    scenario 'user can sign-in' do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
      visit '/sign-in'
      fill_in "Email", with: "fbhewitt@gmail.com"
      fill_in "Password", with: 'password'
      click_button 'Sign In'
      expect(page).to have_content("finn hewitt")
      expect(page).to have_content("Logged In")
      expect(page).to have_content("Your life, organized.")
    end
    scenario 'user can sign-out' do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
      visit '/sign-in'
      fill_in "Email", with: "fbhewitt@gmail.com"
      fill_in "Password", with: 'password'
      click_button 'Sign In'
      click_link "Sign Out"
      expect(page).to have_content("Sign In")
      expect(page).to have_content("Logged Out")
      expect(page).to have_content("Your life, organized.")
    end
  end
