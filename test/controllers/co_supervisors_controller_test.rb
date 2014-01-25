require 'test_helper'

class CoSupervisorsControllerTest < ActionController::TestCase
  setup do
    @co_supervisor = co_supervisors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:co_supervisors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create co_supervisor" do
    assert_difference('CoSupervisor.count') do
      post :create, co_supervisor: { institution: @co_supervisor.institution, name: @co_supervisor.name, teacher_id: @co_supervisor.teacher_id, thesis_supervision_id: @co_supervisor.thesis_supervision_id }
    end

    assert_redirected_to co_supervisor_path(assigns(:co_supervisor))
  end

  test "should show co_supervisor" do
    get :show, id: @co_supervisor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @co_supervisor
    assert_response :success
  end

  test "should update co_supervisor" do
    patch :update, id: @co_supervisor, co_supervisor: { institution: @co_supervisor.institution, name: @co_supervisor.name, teacher_id: @co_supervisor.teacher_id, thesis_supervision_id: @co_supervisor.thesis_supervision_id }
    assert_redirected_to co_supervisor_path(assigns(:co_supervisor))
  end

  test "should destroy co_supervisor" do
    assert_difference('CoSupervisor.count', -1) do
      delete :destroy, id: @co_supervisor
    end

    assert_redirected_to co_supervisors_path
  end
end
