require 'test_helper'

class UnivUnitsControllerTest < ActionController::TestCase
  setup do
    @univ_unit = univ_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:univ_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create univ_unit" do
    assert_difference('UnivUnit.count') do
      post :create, univ_unit: { name: @univ_unit.name }
    end

    assert_redirected_to univ_unit_path(assigns(:univ_unit))
  end

  test "should show univ_unit" do
    get :show, id: @univ_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @univ_unit
    assert_response :success
  end

  test "should update univ_unit" do
    patch :update, id: @univ_unit, univ_unit: { name: @univ_unit.name }
    assert_redirected_to univ_unit_path(assigns(:univ_unit))
  end

  test "should destroy univ_unit" do
    assert_difference('UnivUnit.count', -1) do
      delete :destroy, id: @univ_unit
    end

    assert_redirected_to univ_units_path
  end
end
