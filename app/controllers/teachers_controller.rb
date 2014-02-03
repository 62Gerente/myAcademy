class TeachersController < ApplicationController
  before_filter :authenticate_teacher!
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]


  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
    format.xml { render xml: @teacher.to_xml }
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
  end

  # GET /teachers/1/edit
  def edit
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, notice: 'Teacher was successfully created.' }
        format.json { render action: 'show', status: :created, location: @teacher }
      else
        format.html { render action: 'new' }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url }
      format.json { head :no_content }
    end
  end

  def profile
    @teacher = Teacher.find(current_teacher.id)
    @academicinfo = AcademicInformation.where(teacher_id: current_teacher.id)
    @pub = Publication.where(teacher_id: current_teacher.id)
    @thexam = ThesisExamination.where(teacher_id: current_teacher.id)
    @thesup = ThesisSupervision.where(teacher_id: current_teacher.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:name, :status, :phone, :birthday, :url, :bio, :registed, :institution_id, :email, :encrypted_password)
    end
end
