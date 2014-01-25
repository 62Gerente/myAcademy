require 'test_helper'

class ResearchProjectsControllerTest < ActionController::TestCase
  setup do
    @research_project = research_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:research_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create research_project" do
    assert_difference('ResearchProject.count') do
      post :create, research_project: { b_date: @research_project.b_date, description: @research_project.description, e_date: @research_project.e_date, name: @research_project.name, teacher_id: @research_project.teacher_id, url: @research_project.url }
    end

    assert_redirected_to research_project_path(assigns(:research_project))
  end

  test "should show research_project" do
    get :show, id: @research_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @research_project
    assert_response :success
  end

  test "should update research_project" do
    patch :update, id: @research_project, research_project: { b_date: @research_project.b_date, description: @research_project.description, e_date: @research_project.e_date, name: @research_project.name, teacher_id: @research_project.teacher_id, url: @research_project.url }
    assert_redirected_to research_project_path(assigns(:research_project))
  end

  test "should destroy research_project" do
    assert_difference('ResearchProject.count', -1) do
      delete :destroy, id: @research_project
    end

    assert_redirected_to research_projects_path
  end
end
