class ProjectsController<ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :authorize
  before_action :set_project_access, only: [:show, :edit, :update, :destroy]
  before_action :redirect_non_owners, only: [:edit, :update, :destroy]
  layout "internal"

  def index
    if current_user.admin?
      @projects = Project.all
    else
      @projects = current_user.projects
    end
  end

  def show
    @tasks = @project.tasks
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      Membership.new(user_id: current_user.id, project_id: @project.id, role: :owner).save
      redirect_to project_tasks_path(@project), notice: 'Project was successfully created'
    else
    render :new
    end
  end

  def edit
  end

  def update
  if @project.update(project_params)
    redirect_to project_tasks_path(@project), notice: 'Project was successfully updated'
  else
    render :edit
  end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

end
