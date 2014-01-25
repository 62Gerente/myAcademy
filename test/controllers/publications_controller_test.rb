require 'test_helper'

class PublicationsControllerTest < ActionController::TestCase
  setup do
    @publication = publications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:publications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create publication" do
    assert_difference('Publication.count') do
      post :create, publication: { address: @publication.address, booktitle: @publication.booktitle, chapter: @publication.chapter, date: @publication.date, doi: @publication.doi, howpublished: @publication.howpublished, isbn: @publication.isbn, issn: @publication.issn, journal: @publication.journal, number: @publication.number, pages: @publication.pages, publication_stype_id: @publication.publication_stype_id, publisher: @publication.publisher, research_project_id: @publication.research_project_id, school: @publication.school, teacher_id: @publication.teacher_id, title: @publication.title, uri: @publication.uri, volume: @publication.volume }
    end

    assert_redirected_to publication_path(assigns(:publication))
  end

  test "should show publication" do
    get :show, id: @publication
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @publication
    assert_response :success
  end

  test "should update publication" do
    patch :update, id: @publication, publication: { address: @publication.address, booktitle: @publication.booktitle, chapter: @publication.chapter, date: @publication.date, doi: @publication.doi, howpublished: @publication.howpublished, isbn: @publication.isbn, issn: @publication.issn, journal: @publication.journal, number: @publication.number, pages: @publication.pages, publication_stype_id: @publication.publication_stype_id, publisher: @publication.publisher, research_project_id: @publication.research_project_id, school: @publication.school, teacher_id: @publication.teacher_id, title: @publication.title, uri: @publication.uri, volume: @publication.volume }
    assert_redirected_to publication_path(assigns(:publication))
  end

  test "should destroy publication" do
    assert_difference('Publication.count', -1) do
      delete :destroy, id: @publication
    end

    assert_redirected_to publications_path
  end
end
