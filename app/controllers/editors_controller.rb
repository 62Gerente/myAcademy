class EditorsController < ApplicationController
  before_action :set_editor, only: [:show, :edit, :update, :destroy]

  # GET /editors
  # GET /editors.json
  def index
    @editors = Editor.all
  end

  # GET /editors/1
  # GET /editors/1.json
  def show
  end

  # GET /editors/new
  def new
    @editor = Editor.new
  end

  # GET /editors/1/edit
  def edit
  end

  # POST /editors
  # POST /editors.json
  def create
    @editor = Editor.new(editor_params)

    respond_to do |format|
      if @editor.save
        format.html { redirect_to @editor, notice: 'Editor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @editor }
      else
        format.html { render action: 'new' }
        format.json { render json: @editor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /editors/1
  # PATCH/PUT /editors/1.json
  def update
    respond_to do |format|
      if @editor.update(editor_params)
        format.html { redirect_to @editor, notice: 'Editor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @editor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /editors/1
  # DELETE /editors/1.json
  def destroy
    @editor.destroy
    respond_to do |format|
      format.html { redirect_to editors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_editor
      @editor = Editor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def editor_params
      params.require(:editor).permit(:name, :publication_id, :teacher_id)
    end
end
