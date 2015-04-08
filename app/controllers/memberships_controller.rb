class MembershipsController < ApplicationController
  before_action :set_project
  before_action :set_memberships

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
    if @membership.project.users.count != 1
      if @membership.destroy
        redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully removed"
      end
    else
      redirect_to project_memberships_path(@project, error: "Unable to delete last member of project")
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
