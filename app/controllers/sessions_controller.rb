class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:return_to]
        redirect_to session[:return_to], notice: "Logged In"
      else
        redirect_to projects_path, notice: "Logged In"
      end
    else
      @error = "Email or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:return_to] = nil
    redirect_to root_path, notice: "Logged Out"
  end
end
