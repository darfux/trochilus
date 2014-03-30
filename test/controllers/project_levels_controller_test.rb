require 'test_helper'

class ProjectLevelsControllerTest < ActionController::TestCase
  setup do
    @project_level = project_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_level" do
    assert_difference('ProjectLevel.count') do
      post :create, project_level: { name: @project_level.name }
    end

    assert_redirected_to project_level_path(assigns(:project_level))
  end

  test "should show project_level" do
    get :show, id: @project_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_level
    assert_response :success
  end

  test "should update project_level" do
    patch :update, id: @project_level, project_level: { name: @project_level.name }
    assert_redirected_to project_level_path(assigns(:project_level))
  end

  test "should destroy project_level" do
    assert_difference('ProjectLevel.count', -1) do
      delete :destroy, id: @project_level
    end

    assert_redirected_to project_levels_path
  end
end
