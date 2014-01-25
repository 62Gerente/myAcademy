require 'test_helper'

class ExaminationsControllerTest < ActionController::TestCase
  setup do
    @examination = examinations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examinations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create examination" do
    assert_difference('Examination.count') do
      post :create, examination: { date: @examination.date, description: @examination.description, teacher_id: @examination.teacher_id, thesis_id: @examination.thesis_id }
    end

    assert_redirected_to examination_path(assigns(:examination))
  end

  test "should show examination" do
    get :show, id: @examination
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @examination
    assert_response :success
  end

  test "should update examination" do
    patch :update, id: @examination, examination: { date: @examination.date, description: @examination.description, teacher_id: @examination.teacher_id, thesis_id: @examination.thesis_id }
    assert_redirected_to examination_path(assigns(:examination))
  end

  test "should destroy examination" do
    assert_difference('Examination.count', -1) do
      delete :destroy, id: @examination
    end

    assert_redirected_to examinations_path
  end
end
