require 'test_helper'

class Employee::ManageControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get projects" do
    get :projects
    assert_response :success
  end

  test "should get customers" do
    get :customers
    assert_response :success
  end

  test "should get funds" do
    get :funds
    assert_response :success
  end

end
