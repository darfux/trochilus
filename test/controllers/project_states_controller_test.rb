require 'test_helper'

class ProjectStatesControllerTest < ActionController::TestCase
  setup do
    @project_state = project_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_state" do
    assert_difference('ProjectState.count') do
      post :create, project_state: { name: @project_state.name }
    end

    assert_redirected_to project_state_path(assigns(:project_state))
  end

  test "should show project_state" do
    get :show, id: @project_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_state
    assert_response :success
  end

  test "should update project_state" do
    patch :update, id: @project_state, project_state: { name: @project_state.name }
    assert_redirected_to project_state_path(assigns(:project_state))
  end

  test "should destroy project_state" do
    assert_difference('ProjectState.count', -1) do
      delete :destroy, id: @project_state
    end

    assert_redirected_to project_states_path
  end
end
