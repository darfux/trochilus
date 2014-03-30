require 'test_helper'

class CorporateCustomersControllerTest < ActionController::TestCase
  setup do
    @corporate_customer = corporate_customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:corporate_customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create corporate_customer" do
    assert_difference('CorporateCustomer.count') do
      post :create, corporate_customer: { customer_id: @corporate_customer.customer_id }
    end

    assert_redirected_to corporate_customer_path(assigns(:corporate_customer))
  end

  test "should show corporate_customer" do
    get :show, id: @corporate_customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @corporate_customer
    assert_response :success
  end

  test "should update corporate_customer" do
    patch :update, id: @corporate_customer, corporate_customer: { customer_id: @corporate_customer.customer_id }
    assert_redirected_to corporate_customer_path(assigns(:corporate_customer))
  end

  test "should destroy corporate_customer" do
    assert_difference('CorporateCustomer.count', -1) do
      delete :destroy, id: @corporate_customer
    end

    assert_redirected_to corporate_customers_path
  end
end
