require 'test_helper'

class IndividualCustomersControllerTest < ActionController::TestCase
  setup do
    @individual_customer = individual_customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:individual_customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create individual_customer" do
    assert_difference('IndividualCustomer.count') do
      post :create, individual_customer: { customer_id: @individual_customer.customer_id }
    end

    assert_redirected_to individual_customer_path(assigns(:individual_customer))
  end

  test "should show individual_customer" do
    get :show, id: @individual_customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @individual_customer
    assert_response :success
  end

  test "should update individual_customer" do
    patch :update, id: @individual_customer, individual_customer: { customer_id: @individual_customer.customer_id }
    assert_redirected_to individual_customer_path(assigns(:individual_customer))
  end

  test "should destroy individual_customer" do
    assert_difference('IndividualCustomer.count', -1) do
      delete :destroy, id: @individual_customer
    end

    assert_redirected_to individual_customers_path
  end
end
