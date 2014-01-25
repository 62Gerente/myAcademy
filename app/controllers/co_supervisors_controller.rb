class CoSupervisorsController < ApplicationController
  before_action :set_co_supervisor, only: [:show, :edit, :update, :destroy]

  # GET /co_supervisors
  # GET /co_supervisors.json
  def index
    @co_supervisors = CoSupervisor.all
  end

  # GET /co_supervisors/1
  # GET /co_supervisors/1.json
  def show
  end

  # GET /co_supervisors/new
  def new
    @co_supervisor = CoSupervisor.new
  end

  # GET /co_supervisors/1/edit
  def edit
  end

  # POST /co_supervisors
  # POST /co_supervisors.json
  def create
    @co_supervisor = CoSupervisor.new(co_supervisor_params)

    respond_to do |format|
      if @co_supervisor.save
        format.html { redirect_to @co_supervisor, notice: 'Co supervisor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @co_supervisor }
      else
        format.html { render action: 'new' }
        format.json { render json: @co_supervisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /co_supervisors/1
  # PATCH/PUT /co_supervisors/1.json
  def update
    respond_to do |format|
      if @co_supervisor.update(co_supervisor_params)
        format.html { redirect_to @co_supervisor, notice: 'Co supervisor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @co_supervisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /co_supervisors/1
  # DELETE /co_supervisors/1.json
  def destroy
    @co_supervisor.destroy
    respond_to do |format|
      format.html { redirect_to co_supervisors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_co_supervisor
      @co_supervisor = CoSupervisor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def co_supervisor_params
      params.require(:co_supervisor).permit(:name, :institution, :teacher_id, :thesis_supervision_id)
    end
end
