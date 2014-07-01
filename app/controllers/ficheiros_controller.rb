class FicheirosController < ApplicationController
  before_action :set_ficheiro, only: [:show, :edit, :update, :destroy]

  # GET /files
  # GET /files.json
  def index
    @ficheiros = Ficheiro.all
  end

  # GET /files/1
  # GET /files/1.json
  def show
  end

  # GET /files/new
  def new
    @file = Ficheiro.new
  end

  # GET /files/1/edit
  def edit
  end

  # POST /files
  # POST /files.json
  def create
    @ficheiro = Ficheiro.new(ficheiro_params)

    respond_to do |format|
      if @ficheiro.save
        format.html { redirect_to @ficheiro, notice: 'File was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ficheiro }
      else
        format.html { render action: 'new' }
        format.json { render json: @ficheiro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /files/1
  # PATCH/PUT /files/1.json
  def update
    respond_to do |format|
      if @ficheiro.update(ficheiro_params)
        format.html { redirect_to @ficheiro, notice: 'File was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ficheiro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /files/1
  # DELETE /files/1.json
  def destroy
    @ficheiro.destroy
    respond_to do |format|
      format.html { redirect_to ficheiros_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ficheiro
      @ficheiro = Ficheiro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ficheiro_params
      params.require(:ficheiro).permit(:name, :folder_id, :subject_id, :file)
    end
end
