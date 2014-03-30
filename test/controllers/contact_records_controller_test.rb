require 'test_helper'

class ContactRecordsControllerTest < ActionController::TestCase
  setup do
    @contact_record = contact_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_record" do
    assert_difference('ContactRecord.count') do
      post :create, contact_record: { customer_id: @contact_record.customer_id, employee_id: @contact_record.employee_id }
    end

    assert_redirected_to contact_record_path(assigns(:contact_record))
  end

  test "should show contact_record" do
    get :show, id: @contact_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact_record
    assert_response :success
  end

  test "should update contact_record" do
    patch :update, id: @contact_record, contact_record: { customer_id: @contact_record.customer_id, employee_id: @contact_record.employee_id }
    assert_redirected_to contact_record_path(assigns(:contact_record))
  end

  test "should destroy contact_record" do
    assert_difference('ContactRecord.count', -1) do
      delete :destroy, id: @contact_record
    end

    assert_redirected_to contact_records_path
  end
end
