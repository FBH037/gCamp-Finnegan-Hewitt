class MembershipsController < ApplicationController
  before_action :set_project

  def index
    @membership = Membership.new
    @memberships = @project.memberships
  end

  # def new
  #   @membership = Membership.new
  # end

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
    if @membership.destroy
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully removed"
    end
  end


private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
