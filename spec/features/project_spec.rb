require 'rails_helper'
describe 'User can CRUD project that they are an owner of:' do
  scenario 'User can create project' do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    find("a.btn.pull-right").click
    fill_in 'project_name', :with => 'joe'
    click_on 'Create Project'
    expect(page).to have_content('joe')
  end
  scenario 'User can view a show page' do
    project = Project.create(name: 'joe')
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
    membership = Membership.create(user_id: user.id, project_id: project.id, role: "owner")
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    visit "/projects/#{project.id}/"
    expect(page).to have_content('joe')
  end

  scenario 'User can update a project' do
    project = Project.create(name: 'joe')
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
    membership = Membership.create(user_id: user.id, project_id: project.id, role: "owner")
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    click_on 'Edit'
    fill_in 'Name', :with => 'roe'
    click_on 'Update Project'
    expect(page).to have_content('roe')
  end

  scenario 'User can destroy a project' do
    Project.destroy_all
    project = Project.create(name: 'joe')
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    membership = Membership.create(user_id: user.id, project_id: project.id)
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    visit "projects/#{project.id}/"
    click_on 'Delete'
    expect(page).to have_no_content("joe")
  end
end

describe "Project member can only view a project:" do
  scenario "User can view a project on the projects page but not see the edit button" do
    project = Project.create(name: 'joe')
    otheruser = User.create(first_name: 'other', last_name: 'user', email: 'otheruser@gmail.com', password: 'password', admin: false)
    membership = Membership.create(user_id: otheruser.id, project_id: project.id, role: "member")
    visit '/sign-in'
    fill_in "Email", with: "otheruser@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    expect(page).to have_content("joe")
  end

  scenario "User cannot see edit button on projects index page" do
    project = Project.create(name: 'joe')
    otheruser = User.create(first_name: 'other', last_name: 'user', email: 'otheruser@gmail.com', password: 'password', admin: false)
    membership = Membership.create(user_id: otheruser.id, project_id: project.id, role: "member")
    visit '/sign-in'
    fill_in "Email", with: "otheruser@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    expect(page).to have_content("joe")
    expect(page).to have_no_content("Edit")
  end

  scenario "User cannot see edit button on project show page" do
    project = Project.create(name: 'joe')
    otheruser = User.create(first_name: 'other', last_name: 'user', email: 'otheruser@gmail.com', password: 'password', admin: false)
    membership = Membership.create(user_id: otheruser.id, project_id: project.id, role: "member")
    visit '/sign-in'
    fill_in "Email", with: "otheruser@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    find("#clickme")
    expect(page).to have_content("joe")
    expect(page).to have_no_content("Edit")
  end

end




describe "Admin can CRUD any project:" do
  scenario 'admin user can create a new project' do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    find("a.btn.pull-right").click
    fill_in 'project_name', :with => 'joe'
    click_on 'Create Project'
    expect(page).to have_content('joe')
  end

  scenario 'admin user can view a show page for a project' do
    project = Project.create(name: 'joe')
    adminuser = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
    otheruser = User.create(first_name: 'other', last_name: 'user', email: 'otheruser@gmail.com', password: 'password', admin: false)
    membership = Membership.create(user_id: otheruser.id, project_id: project.id, role: "owner")
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    visit "/projects/#{project.id}/"
    expect(page).to have_content('joe')
  end


  scenario 'admin user can update any project' do
    project = Project.create(name: 'joe')
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
    otheruser = User.create(first_name: 'other', last_name: 'user', email: 'otheruser@gmail.com', password: 'password', admin: false)
    membership = Membership.create(user_id: otheruser.id, project_id: project.id, role: "owner")
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    click_on 'Edit'
    fill_in 'Name', :with => 'roe'
    click_on 'Update Project'
    expect(page).to have_content('roe')
  end

  scenario 'admin user can delete any project' do
    project = Project.create(name: 'joe')
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
    otheruser = User.create(first_name: 'other', last_name: 'user', email: 'otheruser@gmail.com', password: 'password', admin: false)
    membership = Membership.create(user_id: otheruser.id, project_id: project.id, role: "owner")
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    click_on 'Edit'
    click_on "Delete"
    expect(page).to have_content("Project was successfully destroyed")
  end
end
