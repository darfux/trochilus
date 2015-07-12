require 'test_helper'

class WechatDonateControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get notify" do
    get :notify
    assert_response :success
  end

end
