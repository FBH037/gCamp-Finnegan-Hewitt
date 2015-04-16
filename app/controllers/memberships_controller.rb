class MembershipsController < ApplicationController
  before_action :set_project
  before_action :set_memberships
  before_action :set_project_access
  before_action :redirect_non_owners, only: [:new, :create, :edit, :update]
  layout "internal"

  def index
    @membership = Membership.new
  end

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.project_id = @project.id
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully added"
    else
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated"
    else
      render :index
  end
  end

  def destroy
    @membership = Membership.find(params[:id])
    if @membership.user_id == current_user.id || current_user.admin?
      if @membership.project.users.count != 1
        if @membership.destroy
          if @membership.user_id == current_user.id
            redirect_to projects_path, notice: "#{@membership.user.full_name} was successfully removed"
          else
            redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully removed"
          end
        end
      else
        redirect_to project_memberships_path(@project, error: "Projects much have at least one owner")
      end
    end
  end

private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_memberships
    @memberships = @project.memberships
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
