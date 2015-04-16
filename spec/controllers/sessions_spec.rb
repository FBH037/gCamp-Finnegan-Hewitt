require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  # project = Project.create(name: 'joe')
  # user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
  # otheruser = User.create(first_name: 'other', last_name: 'user', email: 'otheruser@gmail.com', password: 'password', admin: false)
  # membership = Membership.create(user_id: otheruser.id, project_id: project.id, role: "owner")
  #


describe "Sessions controller permissions:" do
  it "user can log in " do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
    post :create,
    {email: user.email,
      password: user.password}
      response.should redirect_to projects_path
  end

  it "#authorize redirects you to the sign in page." do
    user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
    post :create,
    {email: user.email,
      password: user.password}
    delete :destroy
      response.should redirect_to root_path
    end

  end
end
