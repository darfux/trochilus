require 'test_helper'

class CustomerTypesControllerTest < ActionController::TestCase
  setup do
    @customer_type = customer_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_type" do
    assert_difference('CustomerType.count') do
      post :create, customer_type: { name: @customer_type.name }
    end

    assert_redirected_to customer_type_path(assigns(:customer_type))
  end

  test "should show customer_type" do
    get :show, id: @customer_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_type
    assert_response :success
  end

  test "should update customer_type" do
    patch :update, id: @customer_type, customer_type: { name: @customer_type.name }
    assert_redirected_to customer_type_path(assigns(:customer_type))
  end

  test "should destroy customer_type" do
    assert_difference('CustomerType.count', -1) do
      delete :destroy, id: @customer_type
    end

    assert_redirected_to customer_types_path
  end
end
