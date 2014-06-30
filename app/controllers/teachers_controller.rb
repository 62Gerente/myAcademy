class TeachersController < ApplicationController
  before_filter :authenticate_teacher!, except: [:show, :search]
  before_action :set_teacher, only: [ :show, :edit, :update, :destroy]


  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
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
        format.html { redirect_to home_path, notice: 'Teacher was successfully created.' }
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
        format.html { redirect_to home_path, notice: 'Teacher was successfully updated.' }
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
  end

  def search
    search = params[:search]
    @teachers_filtered = Teacher.all.order(name: :asc)
    if !@teachers_filtered.blank?
      if !search or search==""
        @teachers_filtered
      else
        @teachers_filtered = @teachers_filtered.find_by_fuzzy_name(search) & @teachers_filtered
      end
    end
    @teachers_filtered
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      if params[:id]
        @teacher = Teacher.find(params[:id])
      else
        @teacher = Teacher.find_by(username: params[:username])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:name, :username,:status, :phone, :birthday, :url, :bio, :registed, :institution_id, :email, :encrypted_password)
    end
end
