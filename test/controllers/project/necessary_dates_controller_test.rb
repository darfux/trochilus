require 'test_helper'

class Project::NecessaryDatesControllerTest < ActionController::TestCase
  setup do
    @project_necessary_date = project_necessary_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_necessary_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_necessary_date" do
    assert_difference('Project::NecessaryDate.count') do
      post :create, project_necessary_date: { comment: @project_necessary_date.comment, date: @project_necessary_date.date, project_id: @project_necessary_date.project_id }
    end

    assert_redirected_to project_necessary_date_path(assigns(:project_necessary_date))
  end

  test "should show project_necessary_date" do
    get :show, id: @project_necessary_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_necessary_date
    assert_response :success
  end

  test "should update project_necessary_date" do
    patch :update, id: @project_necessary_date, project_necessary_date: { comment: @project_necessary_date.comment, date: @project_necessary_date.date, project_id: @project_necessary_date.project_id }
    assert_redirected_to project_necessary_date_path(assigns(:project_necessary_date))
  end

  test "should destroy project_necessary_date" do
    assert_difference('Project::NecessaryDate.count', -1) do
      delete :destroy, id: @project_necessary_date
    end

    assert_redirected_to project_necessary_dates_path
  end
end
