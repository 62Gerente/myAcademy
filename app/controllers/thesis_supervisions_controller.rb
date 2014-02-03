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
  end

  # GET /thesis_supervisions/1/edit
  def edit
  end

  # POST /thesis_supervisions
  # POST /thesis_supervisions.json
  def create
    @thesis_supervision = ThesisSupervision.new(thesis_supervision_params)

    respond_to do |format|
      if @thesis_supervision.save
        format.html { redirect_to @thesis_supervision, notice: 'Thesis supervision was successfully created.' }
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
      params.require(:thesis_supervision).permit(:b, :e_date, :description, :teacher_id, :thesis_id)
    end
end
