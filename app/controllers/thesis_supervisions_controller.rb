class ThesisSupervisionsController < ApplicationController
  before_action :set_thesis_supervision, only: [:show, :edit, :update, :destroy]

  # GET /thesis_supervisions
  # GET /thesis_supervisions.json
  def index
    @thesis_supervisions = ThesisSupervision.all
  end

  # GET /thesis_supervisions/1
  # GET /thesis_supervisions/1.json
  def show
  end

  # GET /thesis_supervisions/new
  def new
    @thesis_supervision = ThesisSupervision.new
    @thesis_supervision.thesis =  Thesis.new
    @teacher = Teacher.find(current_teacher.id)
  end

  # GET /thesis_supervisions/1/edit
  def edit
  end

  # POST /thesis_supervisions
  # POST /thesis_supervisions.json
  def create
    @thesis_supervision = ThesisSupervision.new(
                                                description: thesis_supervision_params[:description]
                                               )
    @thesis_supervision.thesis = Thesis.new(
                                            title: thesis_supervision_params[:title],
                                            student: thesis_supervision_params[:student],
                                            url: thesis_supervision_params[:url],
                                            academic_degree_id: thesis_params[:academic_degree_id],
                                            institution_id: thesis_params[:institution_id]
                                           )

    begin
      @thesis_supervision.b_date = Date.parse(thesis_supervision_params[:b_date])
    rescue ArgumentError
      return redirect_to new_thesis_supervision_path(@thesis_supervision)
    end

    if !thesis_supervision_params[:e_date].blank?
      begin
        @thesis_supervision.e_date = Date.parse(thesis_supervision_params[:e_date])
      rescue ArgumentError
        return redirect_to new_thesis_supervision_path(@thesis_supervision)
      end
    end

    @thesis_supervision.teacher = Teacher.find(current_teacher.id)
    respond_to do |format|
      if @thesis_supervision.save
        format.html { redirect_to :home, notice: 'Thesis supervision was successfully created.' }
        format.json { render action: 'show', status: :created, location: @thesis_supervision }
      else
        format.html { render action: 'new' }
        format.json { render json: @thesis_supervision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /thesis_supervisions/1
  # PATCH/PUT /thesis_supervisions/1.json
  def update
    respond_to do |format|
      if @thesis_supervision.update(thesis_supervision_params)
        format.html { redirect_to @thesis_supervision, notice: 'Thesis supervision was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @thesis_supervision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /thesis_supervisions/1
  # DELETE /thesis_supervisions/1.json
  def destroy
    @thesis_supervision.destroy
    respond_to do |format|
      format.html { redirect_to thesis_supervisions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thesis_supervision
      @thesis_supervision = ThesisSupervision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thesis_supervision_params
      params.require(:thesis_supervision).permit(:b_date, :e_date, :description,:title, :url, :student)
    end

    def thesis_params
      params.require(:thesis).permit(:academic_degree_id, :institution_id)
    end
end
