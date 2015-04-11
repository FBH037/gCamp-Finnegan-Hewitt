class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    if current_user.nil?
      session[:return_to] = request.original_url
      redirect_to signin_path, notice: "Please Log In"
    end
  end

  def set_project_access
    unless @project.memberships.find_by(user_id: current_user.id) || current_user.admin
      redirect_to projects_path, alert: "You do not have access to that project"
    end
  end

  def redirect_non_owners
    unless current_user.memberships.find_by(project_id: @project.id).role == "owner"
      redirect_to projects_path, alert: "You do not have access to that project"
    end
  end

end
