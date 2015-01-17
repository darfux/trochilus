require 'test_helper'

class UndeterminedFundsControllerTest < ActionController::TestCase
  setup do
    @undetermined_fund = undetermined_funds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:undetermined_funds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create undetermined_fund" do
    assert_difference('UndeterminedFund.count') do
      post :create, undetermined_fund: {  }
    end

    assert_redirected_to undetermined_fund_path(assigns(:undetermined_fund))
  end

  test "should show undetermined_fund" do
    get :show, id: @undetermined_fund
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @undetermined_fund
    assert_response :success
  end

  test "should update undetermined_fund" do
    patch :update, id: @undetermined_fund, undetermined_fund: {  }
    assert_redirected_to undetermined_fund_path(assigns(:undetermined_fund))
  end

  test "should destroy undetermined_fund" do
    assert_difference('UndeterminedFund.count', -1) do
      delete :destroy, id: @undetermined_fund
    end

    assert_redirected_to undetermined_funds_path
  end
end
