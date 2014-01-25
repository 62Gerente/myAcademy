require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase
  setup do
    @activity = activities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create activity" do
    assert_difference('Activity.count') do
      post :create, activity: { activity_type: @activity.activity_type, b_date: @activity.b_date, description: @activity.description, e_date: @activity.e_date, name: @activity.name, references: @activity.references, teacher_id: @activity.teacher_id, url: @activity.url }
    end

    assert_redirected_to activity_path(assigns(:activity))
  end

  test "should show activity" do
    get :show, id: @activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @activity
    assert_response :success
  end

  test "should update activity" do
    patch :update, id: @activity, activity: { activity_type: @activity.activity_type, b_date: @activity.b_date, description: @activity.description, e_date: @activity.e_date, name: @activity.name, references: @activity.references, teacher_id: @activity.teacher_id, url: @activity.url }
    assert_redirected_to activity_path(assigns(:activity))
  end

  test "should destroy activity" do
    assert_difference('Activity.count', -1) do
      delete :destroy, id: @activity
    end

    assert_redirected_to activities_path
  end
end
