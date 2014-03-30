require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { balance: @project.balance, brief: @project.brief, create_date: @project.create_date, endowment: @project.endowment, funder: @project.funder, gross: @project.gross, name: @project.name, project_level_id: @project.project_level_id, project_state_id: @project.project_state_id, serialnum: @project.serialnum }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, id: @project, project: { balance: @project.balance, brief: @project.brief, create_date: @project.create_date, endowment: @project.endowment, funder: @project.funder, gross: @project.gross, name: @project.name, project_level_id: @project.project_level_id, project_state_id: @project.project_state_id, serialnum: @project.serialnum }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
