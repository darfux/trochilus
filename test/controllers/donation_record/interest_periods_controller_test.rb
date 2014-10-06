require 'test_helper'

class DonationRecord::InterestPeriodsControllerTest < ActionController::TestCase
  setup do
    @donation_record_interest_period = donation_record_interest_periods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:donation_record_interest_periods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create donation_record_interest_period" do
    assert_difference('DonationRecord::InterestPeriod.count') do
      post :create, donation_record_interest_period: { comment: @donation_record_interest_period.comment, donation_record_id: @donation_record_interest_period.donation_record_id, end: @donation_record_interest_period.end, rate: @donation_record_interest_period.rate, start: @donation_record_interest_period.start }
    end

    assert_redirected_to donation_record_interest_period_path(assigns(:donation_record_interest_period))
  end

  test "should show donation_record_interest_period" do
    get :show, id: @donation_record_interest_period
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @donation_record_interest_period
    assert_response :success
  end

  test "should update donation_record_interest_period" do
    patch :update, id: @donation_record_interest_period, donation_record_interest_period: { comment: @donation_record_interest_period.comment, donation_record_id: @donation_record_interest_period.donation_record_id, end: @donation_record_interest_period.end, rate: @donation_record_interest_period.rate, start: @donation_record_interest_period.start }
    assert_redirected_to donation_record_interest_period_path(assigns(:donation_record_interest_period))
  end

  test "should destroy donation_record_interest_period" do
    assert_difference('DonationRecord::InterestPeriod.count', -1) do
      delete :destroy, id: @donation_record_interest_period
    end

    assert_redirected_to donation_record_interest_periods_path
  end
end
