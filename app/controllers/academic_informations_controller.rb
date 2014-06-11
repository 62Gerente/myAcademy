class AcademicInformationsController < ApplicationController
  before_action :set_academic_information, only: [:show, :edit, :update, :destroy]

  # GET /academic_informations
  # GET /academic_informations.json
  def index
    @academic_informations = AcademicInformation.all
  end

  # GET /academic_informations/1
  # GET /academic_informations/1.json
  def show
  end

  # GET /academic_informations/new
  def new
    @academic_information = AcademicInformation.new
    @teacher = Teacher.find(current_teacher.id)
  end

  # GET /academic_informations/1/edit
  def edit
  end

  # POST /academic_informations
  # POST /academic_informations.json
  def create
    @academic_information = AcademicInformation.new(institution_id: academic_information_params[:institution_id],
                                                    academic_degree_id: academic_information_params[:academic_degree_id],
                                                    grade:  academic_information_params[:grade],
                                                    description: academic_information_params[:description]
                                                   )
    course = Course.where(name: academic_information_params[:course],institution_id: academic_information_params[:institution_id]).first_or_create!
    @academic_information.course = course
    begin
      @academic_information.b_date = Date.parse(academic_information_params[:b_date])
    rescue ArgumentError
      return redirect_to new_academic_information_path(@academic_information)
    end
    if !academic_information_params[:e_date].blank?
      begin
        @academic_information.e_date = Date.parse(academic_information_params[:e_date])
      rescue ArgumentError
        return redirect_to new_academic_information_path(@academic_information)
      end
    end
    @academic_information.teacher = Teacher.find(current_teacher.id)
    respond_to do |format|
      if @academic_information.save
        format.html { redirect_to :home, notice: 'Academic information was successfully created.' }
        format.json { render action: 'show', status: :created, location: @academic_information }
      else
        format.html { render action: 'new' }
        format.json { render json: @academic_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /academic_informations/1
  # PATCH/PUT /academic_informations/1.json
  def update
    respond_to do |format|
      if @academic_information.update(academic_information_params)
        format.html { redirect_to @academic_information, notice: 'Academic information was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @academic_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /academic_informations/1
  # DELETE /academic_informations/1.json
  def destroy
    @academic_information.destroy
    respond_to do |format|
      format.html { redirect_to academic_informations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_academic_information
      @academic_information = AcademicInformation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def academic_information_params
      params.require(:academic_information).permit(:b_date, :e_date, :description, :grade, :academic_degree_id, :course, :institution_id)
    end
end
