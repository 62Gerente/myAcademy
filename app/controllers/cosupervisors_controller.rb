class CosupervisorsController < ApplicationController
  before_action :set_cosupervisor, only: [:show, :edit, :update, :destroy]

  # GET /cosupervisors
  # GET /cosupervisors.json
  def index
    @cosupervisors = Cosupervisor.all
  end

  # GET /cosupervisors/1
  # GET /cosupervisors/1.json
  def show
  end

  # GET /cosupervisors/new
  def new
    @cosupervisor = Cosupervisor.new
  end

  # GET /cosupervisors/1/edit
  def edit
  end

  # POST /cosupervisors
  # POST /cosupervisors.json
  def create
    @cosupervisor = Cosupervisor.new(cosupervisor_params)

    respond_to do |format|
      if @cosupervisor.save
        format.html { redirect_to @cosupervisor, notice: 'Co supervisor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cosupervisor }
      else
        format.html { render action: 'new' }
        format.json { render json: @cosupervisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cosupervisors/1
  # PATCH/PUT /cosupervisors/1.json
  def update
    respond_to do |format|
      if @cosupervisor.update(cosupervisor_params)
        format.html { redirect_to @cosupervisor, notice: 'Co supervisor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cosupervisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cosupervisors/1
  # DELETE /cosupervisors/1.json
  def destroy
    @cosupervisor.destroy
    respond_to do |format|
      format.html { redirect_to cosupervisors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cosupervisor
      @cosupervisor = Cosupervisor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cosupervisor_params
      params.require(:cosupervisor).permit(:name, :institution, :teacher_id, :thesis_supervision_id)
    end
end
