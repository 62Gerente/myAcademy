require 'test_helper'

class AcademicDegreesControllerTest < ActionController::TestCase
  setup do
    @academic_degree = academic_degrees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:academic_degrees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create academic_degree" do
    assert_difference('AcademicDegree.count') do
      post :create, academic_degree: { name: @academic_degree.name }
    end

    assert_redirected_to academic_degree_path(assigns(:academic_degree))
  end

  test "should show academic_degree" do
    get :show, id: @academic_degree
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @academic_degree
    assert_response :success
  end

  test "should update academic_degree" do
    patch :update, id: @academic_degree, academic_degree: { name: @academic_degree.name }
    assert_redirected_to academic_degree_path(assigns(:academic_degree))
  end

  test "should destroy academic_degree" do
    assert_difference('AcademicDegree.count', -1) do
      delete :destroy, id: @academic_degree
    end

    assert_redirected_to academic_degrees_path
  end
end
