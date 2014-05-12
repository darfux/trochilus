require 'test_helper'

class CustomerProjectsControllerTest < ActionController::TestCase
  setup do
    @customer_project = customer_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_project" do
    assert_difference('CustomerProject.count') do
      post :create, customer_project: { customer_id: @customer_project.customer_id, project_id: @customer_project.project_id }
    end

    assert_redirected_to customer_project_path(assigns(:customer_project))
  end

  test "should show customer_project" do
    get :show, id: @customer_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_project
    assert_response :success
  end

  test "should update customer_project" do
    put :update, id: @customer_project, customer_project: { customer_id: @customer_project.customer_id, project_id: @customer_project.project_id }
    assert_redirected_to customer_project_path(assigns(:customer_project))
  end

  test "should destroy customer_project" do
    assert_difference('CustomerProject.count', -1) do
      delete :destroy, id: @customer_project
    end

    assert_redirected_to customer_projects_path
  end
end
