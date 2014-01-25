require 'test_helper'

class AcademicInformationsControllerTest < ActionController::TestCase
  setup do
    @academic_information = academic_informations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:academic_informations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create academic_information" do
    assert_difference('AcademicInformation.count') do
      post :create, academic_information: { academic_degree_id: @academic_information.academic_degree_id, b_date: @academic_information.b_date, course_id: @academic_information.course_id, description: @academic_information.description, e_date: @academic_information.e_date, grade: @academic_information.grade, institution_id: @academic_information.institution_id, teacher_id: @academic_information.teacher_id }
    end

    assert_redirected_to academic_information_path(assigns(:academic_information))
  end

  test "should show academic_information" do
    get :show, id: @academic_information
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @academic_information
    assert_response :success
  end

  test "should update academic_information" do
    patch :update, id: @academic_information, academic_information: { academic_degree_id: @academic_information.academic_degree_id, b_date: @academic_information.b_date, course_id: @academic_information.course_id, description: @academic_information.description, e_date: @academic_information.e_date, grade: @academic_information.grade, institution_id: @academic_information.institution_id, teacher_id: @academic_information.teacher_id }
    assert_redirected_to academic_information_path(assigns(:academic_information))
  end

  test "should destroy academic_information" do
    assert_difference('AcademicInformation.count', -1) do
      delete :destroy, id: @academic_information
    end

    assert_redirected_to academic_informations_path
  end
end
