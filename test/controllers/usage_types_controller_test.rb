require 'test_helper'

class UsageTypesControllerTest < ActionController::TestCase
  setup do
    @usage_type = usage_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usage_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usage_type" do
    assert_difference('UsageType.count') do
      post :create, usage_type: { name: @usage_type.name }
    end

    assert_redirected_to usage_type_path(assigns(:usage_type))
  end

  test "should show usage_type" do
    get :show, id: @usage_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usage_type
    assert_response :success
  end

  test "should update usage_type" do
    patch :update, id: @usage_type, usage_type: { name: @usage_type.name }
    assert_redirected_to usage_type_path(assigns(:usage_type))
  end

  test "should destroy usage_type" do
    assert_difference('UsageType.count', -1) do
      delete :destroy, id: @usage_type
    end

    assert_redirected_to usage_types_path
  end
end
