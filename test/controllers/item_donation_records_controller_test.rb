require 'test_helper'

class ItemDonationRecordsControllerTest < ActionController::TestCase
  setup do
    @item_donation_record = item_donation_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_donation_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_donation_record" do
    assert_difference('ItemDonationRecord.count') do
      post :create, item_donation_record: { creator_id: @item_donation_record.creator_id, customer_id: @item_donation_record.customer_id, project_id: @item_donation_record.project_id }
    end

    assert_redirected_to item_donation_record_path(assigns(:item_donation_record))
  end

  test "should show item_donation_record" do
    get :show, id: @item_donation_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_donation_record
    assert_response :success
  end

  test "should update item_donation_record" do
    patch :update, id: @item_donation_record, item_donation_record: { creator_id: @item_donation_record.creator_id, customer_id: @item_donation_record.customer_id, project_id: @item_donation_record.project_id }
    assert_redirected_to item_donation_record_path(assigns(:item_donation_record))
  end

  test "should destroy item_donation_record" do
    assert_difference('ItemDonationRecord.count', -1) do
      delete :destroy, id: @item_donation_record
    end

    assert_redirected_to item_donation_records_path
  end
end
