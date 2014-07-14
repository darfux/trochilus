require 'test_helper'

class DonationRecordsControllerTest < ActionController::TestCase
  setup do
    @donation_record = donation_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:donation_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create donation_record" do
    assert_difference('DonationRecord.count') do
      post :create, donation_record: { creator_id: @donation_record.creator_id, customer_id: @donation_record.customer_id, donation_type_id: @donation_record.donation_type_id, plan_fund_id: @donation_record.plan_fund_id, project_id: @donation_record.project_id }
    end

    assert_redirected_to donation_record_path(assigns(:donation_record))
  end

  test "should show donation_record" do
    get :show, id: @donation_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @donation_record
    assert_response :success
  end

  test "should update donation_record" do
    patch :update, id: @donation_record, donation_record: { creator_id: @donation_record.creator_id, customer_id: @donation_record.customer_id, donation_type_id: @donation_record.donation_type_id, plan_fund_id: @donation_record.plan_fund_id, project_id: @donation_record.project_id }
    assert_redirected_to donation_record_path(assigns(:donation_record))
  end

  test "should destroy donation_record" do
    assert_difference('DonationRecord.count', -1) do
      delete :destroy, id: @donation_record
    end

    assert_redirected_to donation_records_path
  end
end
