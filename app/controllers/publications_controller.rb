class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :edit, :update, :destroy]

  # GET /publications
  # GET /publications.json
  def index
    @publications = Publication.all
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
  end

  # GET /publications/new
  def new
    @publication = Publication.new
    @teacher = Teacher.find(current_teacher.id)
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(publication_params)

    begin
      @publication.date = Date.parse(publication_params[:date])
    rescue ArgumentError
      return redirect_to new_publication_path(@academic_information)
    end

    @publication.teacher = Teacher.find(current_teacher.id)

    respond_to do |format|
      if @publication.save
        format.html { redirect_to :home, notice: 'Publication was successfully created.' }
        format.json { render action: 'show', status: :created, location: @publication }
      else
        format.html { render action: 'new' }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: 'Publication was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to publications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:title, :chapter, :pages, :publisher, :doi, :volume, :isbn, :issn, :date, :booktitle, :address, :uri, :journal, :number, :howpublished, :school, :publication_type_id, :teacher_id, :research_project_id)
    end
end
