require 'test_helper'

class OrgnizationCustomersControllerTest < ActionController::TestCase
  setup do
    @orgnization_customer = orgnization_customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orgnization_customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orgnization_customer" do
    assert_difference('OrgnizationCustomer.count') do
      post :create, orgnization_customer: { customer_id: @orgnization_customer.customer_id }
    end

    assert_redirected_to orgnization_customer_path(assigns(:orgnization_customer))
  end

  test "should show orgnization_customer" do
    get :show, id: @orgnization_customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @orgnization_customer
    assert_response :success
  end

  test "should update orgnization_customer" do
    patch :update, id: @orgnization_customer, orgnization_customer: { customer_id: @orgnization_customer.customer_id }
    assert_redirected_to orgnization_customer_path(assigns(:orgnization_customer))
  end

  test "should destroy orgnization_customer" do
    assert_difference('OrgnizationCustomer.count', -1) do
      delete :destroy, id: @orgnization_customer
    end

    assert_redirected_to orgnization_customers_path
  end
end
