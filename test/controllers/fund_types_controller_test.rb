require 'test_helper'

class FundTypesControllerTest < ActionController::TestCase
  setup do
    @fund_type = fund_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fund_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fund_type" do
    assert_difference('FundType.count') do
      post :create, fund_type: { name: @fund_type.name }
    end

    assert_redirected_to fund_type_path(assigns(:fund_type))
  end

  test "should show fund_type" do
    get :show, id: @fund_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fund_type
    assert_response :success
  end

  test "should update fund_type" do
    patch :update, id: @fund_type, fund_type: { name: @fund_type.name }
    assert_redirected_to fund_type_path(assigns(:fund_type))
  end

  test "should destroy fund_type" do
    assert_difference('FundType.count', -1) do
      delete :destroy, id: @fund_type
    end

    assert_redirected_to fund_types_path
  end
end
