require 'test_helper'

class TeachersControllerTest < ActionController::TestCase
  setup do
    @teacher = teachers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teachers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teacher" do
    assert_difference('Teacher.count') do
      post :create, teacher: { bio: @teacher.bio, birthday: @teacher.birthday, email: @teacher.email, encrypted_password: @teacher.encrypted_password, institution_id: @teacher.institution_id, name: @teacher.name, phone: @teacher.phone, registed: @teacher.registed, status: @teacher.status, url: @teacher.url }
    end

    assert_redirected_to teacher_path(assigns(:teacher))
  end

  test "should show teacher" do
    get :show, id: @teacher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teacher
    assert_response :success
  end

  test "should update teacher" do
    patch :update, id: @teacher, teacher: { bio: @teacher.bio, birthday: @teacher.birthday, email: @teacher.email, encrypted_password: @teacher.encrypted_password, institution_id: @teacher.institution_id, name: @teacher.name, phone: @teacher.phone, registed: @teacher.registed, status: @teacher.status, url: @teacher.url }
    assert_redirected_to teacher_path(assigns(:teacher))
  end

  test "should destroy teacher" do
    assert_difference('Teacher.count', -1) do
      delete :destroy, id: @teacher
    end

    assert_redirected_to teachers_path
  end
end
