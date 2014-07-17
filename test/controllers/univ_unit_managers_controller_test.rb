require 'test_helper'

class UnivUnitManagersControllerTest < ActionController::TestCase
  setup do
    @univ_unit_manager = univ_unit_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:univ_unit_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create univ_unit_manager" do
    assert_difference('UnivUnitManager.count') do
      post :create, univ_unit_manager: { name: @univ_unit_manager.name, univ_unit_id: @univ_unit_manager.univ_unit_id }
    end

    assert_redirected_to univ_unit_manager_path(assigns(:univ_unit_manager))
  end

  test "should show univ_unit_manager" do
    get :show, id: @univ_unit_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @univ_unit_manager
    assert_response :success
  end

  test "should update univ_unit_manager" do
    patch :update, id: @univ_unit_manager, univ_unit_manager: { name: @univ_unit_manager.name, univ_unit_id: @univ_unit_manager.univ_unit_id }
    assert_redirected_to univ_unit_manager_path(assigns(:univ_unit_manager))
  end

  test "should destroy univ_unit_manager" do
    assert_difference('UnivUnitManager.count', -1) do
      delete :destroy, id: @univ_unit_manager
    end

    assert_redirected_to univ_unit_managers_path
  end
end
