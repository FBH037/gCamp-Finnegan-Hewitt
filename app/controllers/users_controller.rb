class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authorize
  before_action :set_user_access, only: [:show, :edit, :update, :destroy]
  before_action :set_user_edit, only: [:edit, :update, :destroy]
  layout "internal"


  def index
    @users = (User.all.reverse - [current_user])
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

  def set_user_access
    unless @user.id == current_user.id || current_user.admin || @user.memberships.any? {|membership| current_user.memberships.map{|current_mem| current_mem.project_id}.include?(membership.project_id)}
      render :file => 'public/404.html', :status => :not_found, :layout => false
    end
  end

  def set_user_edit
    unless @user.id == current_user.id || current_user.admin
        render :file => 'public/404.html', :status => :not_found, :layout => false
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if current_user.admin
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end


end
