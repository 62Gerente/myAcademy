class ThesisExaminationsController < ApplicationController
  before_action :set_thesis_examination, only: [:show, :edit, :update, :destroy]

  # GET /thesis_examinations
  # GET /thesis_examinations.json
  def index
    @thesis_examinations = ThesisExamination.all
  end

  # GET /thesis_examinations/1
  # GET /thesis_examinations/1.json
  def show
  end

  # GET /thesis_examinations/new
  def new
    @thesis_examination = ThesisExamination.new
    @thesis_examination.thesis =  Thesis.new
    @teacher = Teacher.find(current_teacher.id)
  end

  # GET /thesis_examinations/1/edit
  def edit
  end

  # POST /thesis_examinations
  # POST /thesis_examinations.json
  def create
    @thesis_examination = ThesisExamination.new(
                                                description: thesis_examination_params[:description]
                                               )
    @thesis_examination.thesis = Thesis.new(
                                            title: thesis_examination_params[:title],
                                            student: thesis_examination_params[:student],
                                            url: thesis_examination_params[:url],
                                            academic_degree_id: thesis_params[:academic_degree_id],
                                            institution_id: thesis_params[:institution_id]
                                           )

    begin
      @thesis_examination.date = Date.parse(thesis_examination_params[:date])
    rescue ArgumentError
      return redirect_to new_thesis_examination_path(@thesis_examination)
    end

    @thesis_examination.teacher = Teacher.find(current_teacher.id)

    respond_to do |format|
      if @thesis_examination.save
        format.html { redirect_to :home, notice: 'Thesis examination was successfully created.' }
        format.json { render action: 'show', status: :created, location: @thesis_examination }
      else
        format.html { render action: 'new' }
        format.json { render json: @thesis_examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /thesis_examinations/1
  # PATCH/PUT /thesis_examinations/1.json
  def update
    respond_to do |format|
      if @thesis_examination.update(thesis_examination_params)
        format.html { redirect_to @thesis_examination, notice: 'Thesis examination was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @thesis_examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /thesis_examinations/1
  # DELETE /thesis_examinations/1.json
  def destroy
    @thesis_examination.destroy
    respond_to do |format|
      format.html { redirect_to thesis_examinations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thesis_examination
      @thesis_examination = ThesisExamination.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thesis_examination_params
      params.require(:thesis_examination).permit(:date, :description,:title, :url, :student)
    end

    def thesis_params
      params.require(:thesis).permit(:academic_degree_id, :institution_id)
    end
end
