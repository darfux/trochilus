require 'test_helper'

class FundsControllerTest < ActionController::TestCase
  setup do
    @fund = funds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:funds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fund" do
    assert_difference('Fund.count') do
      post :create, fund: { amount: @fund.amount, comment: @fund.comment, currency_id: @fund.currency_id, fund_type_id: @fund.fund_type_id, origin_amount: @fund.origin_amount, time: @fund.time }
    end

    assert_redirected_to fund_path(assigns(:fund))
  end

  test "should show fund" do
    get :show, id: @fund
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fund
    assert_response :success
  end

  test "should update fund" do
    patch :update, id: @fund, fund: { amount: @fund.amount, comment: @fund.comment, currency_id: @fund.currency_id, fund_type_id: @fund.fund_type_id, origin_amount: @fund.origin_amount, time: @fund.time }
    assert_redirected_to fund_path(assigns(:fund))
  end

  test "should destroy fund" do
    assert_difference('Fund.count', -1) do
      delete :destroy, id: @fund
    end

    assert_redirected_to funds_path
  end
end
