class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authorize
  layout "internal"
  

  def index
  @users = User.all.reverse
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if session[:user_id].nil?
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'User was successfully created.'
      else
        redirect_to users_path, notice: 'User was successfully created.'
      end
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.comments.each do |comment|
      comment.user_id = nil
      comment.save
    end
    if session[:user_id] == @user.id then session[:user_id] = nil end
    @user.destroy
    redirect_to users_path, notice: 'User was successfully destroyed.'
  end


private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
