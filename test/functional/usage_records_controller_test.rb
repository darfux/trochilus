require 'test_helper'

class UsageRecordsControllerTest < ActionController::TestCase
  setup do
    @usage_record = usage_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usage_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usage_record" do
    assert_difference('UsageRecord.count') do
      post :create, usage_record: {  }
    end

    assert_redirected_to usage_record_path(assigns(:usage_record))
  end

  test "should show usage_record" do
    get :show, id: @usage_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usage_record
    assert_response :success
  end

  test "should update usage_record" do
    put :update, id: @usage_record, usage_record: {  }
    assert_redirected_to usage_record_path(assigns(:usage_record))
  end

  test "should destroy usage_record" do
    assert_difference('UsageRecord.count', -1) do
      delete :destroy, id: @usage_record
    end

    assert_redirected_to usage_records_path
  end
end
