class AcademicDegreesController < ApplicationController
  before_action :set_academic_degree, only: [:show, :edit, :update, :destroy]

  # GET /academic_degrees
  # GET /academic_degrees.json
  def index
    @academic_degrees = AcademicDegree.all
  end

  # GET /academic_degrees/1
  # GET /academic_degrees/1.json
  def show
  end

  # GET /academic_degrees/new
  def new
    @academic_degree = AcademicDegree.new
  end

  # GET /academic_degrees/1/edit
  def edit
  end

  # POST /academic_degrees
  # POST /academic_degrees.json
  def create
    @academic_degree = AcademicDegree.new(academic_degree_params)

    respond_to do |format|
      if @academic_degree.save
        format.html { redirect_to @academic_degree, notice: 'Academic degree was successfully created.' }
        format.json { render action: 'show', status: :created, location: @academic_degree }
      else
        format.html { render action: 'new' }
        format.json { render json: @academic_degree.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /academic_degrees/1
  # PATCH/PUT /academic_degrees/1.json
  def update
    respond_to do |format|
      if @academic_degree.update(academic_degree_params)
        format.html { redirect_to @academic_degree, notice: 'Academic degree was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @academic_degree.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /academic_degrees/1
  # DELETE /academic_degrees/1.json
  def destroy
    @academic_degree.destroy
    respond_to do |format|
      format.html { redirect_to academic_degrees_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_academic_degree
      @academic_degree = AcademicDegree.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def academic_degree_params
      params.require(:academic_degree).permit(:name)
    end
end
