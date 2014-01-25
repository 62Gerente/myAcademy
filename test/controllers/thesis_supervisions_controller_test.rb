require 'test_helper'

class ThesisSupervisionsControllerTest < ActionController::TestCase
  setup do
    @thesis_supervision = thesis_supervisions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thesis_supervisions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thesis_supervision" do
    assert_difference('ThesisSupervision.count') do
      post :create, thesis_supervision: { b: @thesis_supervision.b, description: @thesis_supervision.description, e_date: @thesis_supervision.e_date, teacher_id: @thesis_supervision.teacher_id, thesis_id: @thesis_supervision.thesis_id }
    end

    assert_redirected_to thesis_supervision_path(assigns(:thesis_supervision))
  end

  test "should show thesis_supervision" do
    get :show, id: @thesis_supervision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @thesis_supervision
    assert_response :success
  end

  test "should update thesis_supervision" do
    patch :update, id: @thesis_supervision, thesis_supervision: { b: @thesis_supervision.b, description: @thesis_supervision.description, e_date: @thesis_supervision.e_date, teacher_id: @thesis_supervision.teacher_id, thesis_id: @thesis_supervision.thesis_id }
    assert_redirected_to thesis_supervision_path(assigns(:thesis_supervision))
  end

  test "should destroy thesis_supervision" do
    assert_difference('ThesisSupervision.count', -1) do
      delete :destroy, id: @thesis_supervision
    end

    assert_redirected_to thesis_supervisions_path
  end
end
