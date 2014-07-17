require 'test_helper'

class OnlineCustomersControllerTest < ActionController::TestCase
  setup do
    @online_customer = online_customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:online_customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create online_customer" do
    assert_difference('OnlineCustomer.count') do
      post :create, online_customer: {  }
    end

    assert_redirected_to online_customer_path(assigns(:online_customer))
  end

  test "should show online_customer" do
    get :show, id: @online_customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @online_customer
    assert_response :success
  end

  test "should update online_customer" do
    patch :update, id: @online_customer, online_customer: {  }
    assert_redirected_to online_customer_path(assigns(:online_customer))
  end

  test "should destroy online_customer" do
    assert_difference('OnlineCustomer.count', -1) do
      delete :destroy, id: @online_customer
    end

    assert_redirected_to online_customers_path
  end
end
