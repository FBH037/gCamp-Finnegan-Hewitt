require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  # project = Project.create(name: 'joe')
  # user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
  # otheruser = User.create(first_name: 'other', last_name: 'user', email: 'otheruser@gmail.com', password: 'password', admin: false)
  # membership = Membership.create(user_id: otheruser.id, project_id: project.id, role: "owner")
  #


  describe "GET #index" do
    render_views
    it "Non-logged in User cannot render index" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      get :index
      response.should redirect_to signin_path
    end

    it "Logged-in User can render index" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      session[:user_id] = user.id
      get :index
      expect(response).to render_template(:index)
    end

    it "Logged-in member can render index" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "member")
      session[:user_id] = user.id
      get :index
      expect(response).to render_template(:index)
    end

    it "Logged-in owner can render index" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "owner")
      session[:user_id] = user.id
      get :index
      expect(response).to render_template(:index)
    end

    it "Logged-in admin can render index" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
      project = Project.create(name: 'joe')
      session[:user_id] = user.id
      get :index
      expect(response).to render_template(:index)
    end

    it "Logged-in admin member can render index" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "member")
      session[:user_id] = user.id
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "Non-logged in User cannot render show" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      get :show, id: project.id
      expect(response).to redirect_to signin_path
    end

    it "Logged-in User can not render show" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      session[:user_id] = user.id
      get :show, id: project.id
      expect(response).to redirect_to projects_path
    end

    it "Logged-in member can render show" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "member")
      session[:user_id] = user.id
      get :show, id: project.id
      expect(response).to render_template(:show)
    end

    it "Logged-in owner can render show" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "owner")
      session[:user_id] = user.id
      get :show, id: project.id
      expect(response).to render_template(:show)
    end

    it "Logged-in admin can render show" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
      project = Project.create(name: 'joe')
      session[:user_id] = user.id
      get :show, id: project.id
      expect(response).to render_template(:show)
    end

    it "Logged-in admin member can render show" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "member")
      session[:user_id] = user.id
      get :show, id: project.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "Non-logged in User cannot render new" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      get :new
      expect(response).to redirect_to signin_path
    end

    it "Logged-in User can render new" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      session[:user_id] = user.id
      get :new
      expect(response).to render_template(:new)
    end

    it "Logged-in member can render new" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "member")
      session[:user_id] = user.id
      get :new
      expect(response).to render_template(:new)
    end

    it "Logged-in owner can render new" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "owner")
      session[:user_id] = user.id
      get :new
      expect(response).to render_template(:new)
    end

    it "Logged-in admin can render new" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
      project = Project.create(name: 'joe')
      session[:user_id] = user.id
      get :new
      expect(response).to render_template(:new)
    end

    it "Logged-in admin member can render new" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "member")
      session[:user_id] = user.id
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #create" do
    it "Non-logged in User post to render create" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      post :create
      expect(response).to redirect_to signin_path
    end

    it "Logged-in User can post to create" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      session[:user_id] = user.id
      post :create, project: {name: "nagannif"}
      expect(response).to redirect_to "/projects/#{Project.last.id}/tasks"
    end

    it "Logged-in member can post to create" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "member")
      session[:user_id] = user.id
      post :create, project: {name: "nagannif"}
      expect(response).to redirect_to "/projects/#{Project.last.id}/tasks"
    end

    it "Logged-in owner can post to create" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "owner")
      session[:user_id] = user.id
      post :create, project: {name: "nagannif"}
      expect(response).to redirect_to "/projects/#{Project.last.id}/tasks"
    end

    it "Logged-in admin can post to create" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
      project = Project.create(name: 'joe')
      session[:user_id] = user.id
      post :create, project: {name: "nagannif"}
      expect(response).to redirect_to "/projects/#{Project.last.id}/tasks"
    end

    it "Logged-in admin member can post to create" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "member")
      session[:user_id] = user.id
      post :create, project: {name: "nagannif"}
      expect(response).to redirect_to "/projects/#{Project.last.id}/tasks"
    end
  end

  describe "GET #edit" do
    it "Non-logged in User cannot render edit" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      get :edit, id: project.id
      expect(response).to redirect_to signin_path
    end

    it "Logged-in User can not render edit" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(response).to redirect_to projects_path
    end

    it "Logged-in member can not render edit" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: false)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "member")
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(response).to redirect_to projects_path
    end

    it "Logged-in admin can render edit" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
      project = Project.create(name: 'joe')
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(response).to render_template(:edit)
    end

    it "Logged-in admin member can render edit" do
      user = User.create(first_name: 'finn', last_name: 'hewitt', email: 'fbhewitt@gmail.com', password: 'password', admin: true)
      project = Project.create(name: 'joe')
      membership = Membership.create(user_id: user.id, project_id: project.id, role: "member")
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(response).to render_template(:edit)
    end
  end

end
