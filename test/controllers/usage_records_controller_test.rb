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
      post :create, usage_record: { benefit_manager_id: @usage_record.benefit_manager_id, benefit_unit_id: @usage_record.benefit_unit_id, employee_id: @usage_record.employee_id, exec_manager_id: @usage_record.exec_manager_id, exec_unit_id: @usage_record.exec_unit_id, fund_id: @usage_record.fund_id, project_id: @usage_record.project_id, usage_type_id: @usage_record.usage_type_id }
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
    patch :update, id: @usage_record, usage_record: { benefit_manager_id: @usage_record.benefit_manager_id, benefit_unit_id: @usage_record.benefit_unit_id, employee_id: @usage_record.employee_id, exec_manager_id: @usage_record.exec_manager_id, exec_unit_id: @usage_record.exec_unit_id, fund_id: @usage_record.fund_id, project_id: @usage_record.project_id, usage_type_id: @usage_record.usage_type_id }
    assert_redirected_to usage_record_path(assigns(:usage_record))
  end

  test "should destroy usage_record" do
    assert_difference('UsageRecord.count', -1) do
      delete :destroy, id: @usage_record
    end

    assert_redirected_to usage_records_path
  end
end
