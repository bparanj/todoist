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
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def show
    @project = Project.find(params[:id])  
  end
  
  def update
    @project = Project.find(params[:id])  
    if @project.update_attributes(allowed_params)
      redirect_to @project, notice: 'Successfully updated survey'
    else
      render :edit
    end
  end
  
  private
  
  def allowed_params
    params.require(:project).permit(:name, tasks_attributes: [:id, :name, :_destroy])
  end
end
