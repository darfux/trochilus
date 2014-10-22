require 'test_helper'

class RegionControllerTest < ActionController::TestCase
  test "should get country" do
    get :country
    assert_response :success
  end

  test "should get state" do
    get :state
    assert_response :success
  end

  test "should get city" do
    get :city
    assert_response :success
  end

end
