require 'rails_helper'
describe 'user can CRUD project' do
  scenario 'user can create project' do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    click_on 'Projects'
    click_on "New Project"
    fill_in 'Name', :with => 'joe'
    click_on 'Create Project'
    expect(page).to have_content('joe')
  end
  scenario 'user can view a show page for a project' do
    project = Project.create(name: 'joe')
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    click_on 'Projects'
    visit "/projects/#{project.id}"
    expect(page).to have_content('joe')
  end
  scenario 'user can update a project' do
    Project.create(name: 'joe')
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    click_on 'Projects'
    visit '/projects'
    click_on 'Edit'
    fill_in 'Name', :with => 'roe'
    click_on 'Update Project'
    expect(page).to have_content('roe')
  end
  scenario 'user can destroy a project' do
    Project.destroy_all
    project = Project.create(name: 'joe')
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    click_on 'Projects'
    visit "projects/#{project.id}/edit"
    click_on 'Delete'
    expect(page).to have_no_content("joe")
  end
end
