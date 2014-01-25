require 'test_helper'

class PublicationTypesControllerTest < ActionController::TestCase
  setup do
    @publication_type = publication_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:publication_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create publication_type" do
    assert_difference('PublicationType.count') do
      post :create, publication_type: { name: @publication_type.name }
    end

    assert_redirected_to publication_type_path(assigns(:publication_type))
  end

  test "should show publication_type" do
    get :show, id: @publication_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @publication_type
    assert_response :success
  end

  test "should update publication_type" do
    patch :update, id: @publication_type, publication_type: { name: @publication_type.name }
    assert_redirected_to publication_type_path(assigns(:publication_type))
  end

  test "should destroy publication_type" do
    assert_difference('PublicationType.count', -1) do
      delete :destroy, id: @publication_type
    end

    assert_redirected_to publication_types_path
  end
end
