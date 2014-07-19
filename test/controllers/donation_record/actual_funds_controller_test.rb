require 'test_helper'

class DonationRecord::ActualFundsControllerTest < ActionController::TestCase
  setup do
    @donation_record_actual_fund = donation_record_actual_funds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:donation_record_actual_funds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create donation_record_actual_fund" do
    assert_difference('DonationRecord::ActualFund.count') do
      post :create, donation_record_actual_fund: {  }
    end

    assert_redirected_to donation_record_actual_fund_path(assigns(:donation_record_actual_fund))
  end

  test "should show donation_record_actual_fund" do
    get :show, id: @donation_record_actual_fund
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @donation_record_actual_fund
    assert_response :success
  end

  test "should update donation_record_actual_fund" do
    patch :update, id: @donation_record_actual_fund, donation_record_actual_fund: {  }
    assert_redirected_to donation_record_actual_fund_path(assigns(:donation_record_actual_fund))
  end

  test "should destroy donation_record_actual_fund" do
    assert_difference('DonationRecord::ActualFund.count', -1) do
      delete :destroy, id: @donation_record_actual_fund
    end

    assert_redirected_to donation_record_actual_funds_path
  end
end
