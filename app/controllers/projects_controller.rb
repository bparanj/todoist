class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    3.times { @project.tasks.build }
  end

  def create        
    @project = Project.new(allowed_params)

    if @project.save
      flash[:notice] = 'Successfully created project.'
      
      redirect_to projects_path
    else
      render :new
    end
  end
  
  private
  
  def allowed_params
    params.require(:project).permit(:name, tasks_attributes: [:name])
  end
end
