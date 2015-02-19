require 'rails_helper'




describe 'user can CRUD a Task' do
  scenario 'user can create a Location' do
    visit '/'
    click_on "Tasks"
    click_on "New Task"
    fill_in 'task_description', :with => "capy_test"
    click_on "Create Task"
    expect(page).to have_content("capy_test")
    expect(page).to have_content("Task was successfully created")
  end

  scenario 'user can view a show page for a Task' do
    @task = Task.create(description: "capy_test")
    visit("tasks/#{@task.id}")
    expect(page).to have_content('capy_test')
  end

  scenario "user can edit a Task" do
     @task = Task.create(description: "capy_test")
    visit("tasks/#{@task.id}")
    click_on "Edit"
    fill_in 'task_description', :with => 'capy_test_edit'
    click_on 'Update Task'
    expect(page).to have_content('capy_test_edit')
    expect(page).to have_content('Task was successfully updated')
  end

  scenario 'user can delete a Task' do
    @task = Task.create(description: "capy_test")
    visit('tasks')
    click_on "Delete"
    expect(page).to have_content('Task was successfully destroyed')
    expect(page).to have_no_content('capy_test')

  end

end
