require 'rails_helper'
describe 'user can CRUD project' do
  scenario 'user can create project' do
    visit '/projects'
    click_on "New Project"
    fill_in 'Name', :with => 'joe'
    click_on 'Create Project'
    expect(page).to have_content('joe')
  end
  scenario 'user can view a show page for a project' do
    project = Project.create(name: 'joe')
    visit "/projects/#{project.id}"
    expect(page).to have_content('joe')
  end
  scenario 'user can update a project' do
    Project.create(name: 'joe')
    visit '/projects'
    click_on 'Edit'
    fill_in 'Name', :with => 'roe'
    click_on 'Update Project'
    expect(page).to have_content('roe')
  end
  scenario 'user can destroy a project' do
    Project.destroy_all
    project = Project.create(name: 'joe')
    visit "projects/#{project.id}/edit"
    click_on 'Delete'
    expect(page).to have_no_content("joe")
  end
end
