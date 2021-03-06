require 'rails_helper'

describe 'user can CRUD a Task' do
  scenario 'user can create a Task' do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    project = Project.create(name: "projectile")
    membership = Membership.create(user_id: user.id, project_id: project.id)
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    find("#clickme").click
    click_on "0 Tasks"
    click_on "Add Task"
    fill_in 'task_description', :with => "capy_test"
    click_on "Create Task"
    expect(page).to have_content("capy_test")
    expect(page).to have_content("Task was successfully created")
  end

  scenario 'user can view a show page for a Task' do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    project = Project.create(name: "projectile")
    task = Task.create(description: "capy_test", project_id: project.id, due_date: Date.today)
    membership = Membership.create(user_id: user.id, project_id: project.id, role: "owner")
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    visit("/projects/#{project.id}/tasks/#{task.id}")
    expect(page).to have_content('capy_test')
  end

  scenario "user can edit a Task" do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    project = Project.create(name: "projectile")
    task = Task.create(description: "capy_test", project_id: project.id, due_date: Date.today)
    membership = Membership.create(user_id: user.id, project_id: project.id, role: "owner")
    visit '/sign-in'
     fill_in "Email", with: "fbhewitt@gmail.com"
     fill_in "Password", with: 'password'
     click_button 'Sign In'
    visit("projects/#{project.id}/tasks/#{task.id}")
    click_on "Edit"
    fill_in 'task_description', :with => 'capy_test_edit'
    click_on 'Update Task'
    expect(page).to have_content('capy_test_edit')
    expect(page).to have_content('Task was successfully updated')
  end

  scenario 'user can delete a Task' do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password')
    project = Project.create(name: "projectile")
    task = Task.create(description: "capy_test", project_id: project.id, due_date: Date.today)
    membership = Membership.create(user_id: user.id, project_id: project.id, role: "owner")
    visit '/sign-in'
    fill_in "Email", with: "fbhewitt@gmail.com"
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    visit("projects/#{project.id}/tasks/")
    click_link( "ex")
    expect(page).to have_content('Task was successfully destroyed')
    expect(page).to have_no_content('capy_test')
  end

end
