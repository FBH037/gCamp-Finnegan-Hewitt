class RegistrationsController < ApplicationController

  def new
    @registration = User.new
  end

  def create
    @registration = User.new(user_params)
    if @registration.save
      session[:user_id] = @registration.id
      redirect_to new_project_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

private
def user_params
  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
end

end
