class ResearchProjectsController < ApplicationController
  before_action :set_research_project, only: [:show, :edit, :update, :destroy]

  # GET /research_projects
  # GET /research_projects.json
  def index
    @research_projects = ResearchProject.all
  end

  # GET /research_projects/1
  # GET /research_projects/1.json
  def show
  end

  # GET /research_projects/new
  def new
    @research_project = ResearchProject.new
  end

  # GET /research_projects/1/edit
  def edit
  end

  # POST /research_projects
  # POST /research_projects.json
  def create
    @research_project = ResearchProject.new(research_project_params)

    respond_to do |format|
      if @research_project.save
        format.html { redirect_to @research_project, notice: 'Research project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @research_project }
      else
        format.html { render action: 'new' }
        format.json { render json: @research_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /research_projects/1
  # PATCH/PUT /research_projects/1.json
  def update
    respond_to do |format|
      if @research_project.update(research_project_params)
        format.html { redirect_to @research_project, notice: 'Research project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @research_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /research_projects/1
  # DELETE /research_projects/1.json
  def destroy
    @research_project.destroy
    respond_to do |format|
      format.html { redirect_to research_projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_research_project
      @research_project = ResearchProject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def research_project_params
      params.require(:research_project).permit(:name, :url, :b_date, :e_date, :description, :teacher_id)
    end
end
