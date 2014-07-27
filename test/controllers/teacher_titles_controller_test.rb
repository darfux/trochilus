require 'test_helper'

class TeacherTitlesControllerTest < ActionController::TestCase
  setup do
    @teacher_title = teacher_titles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teacher_titles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teacher_title" do
    assert_difference('TeacherTitle.count') do
      post :create, teacher_title: { name: @teacher_title.name }
    end

    assert_redirected_to teacher_title_path(assigns(:teacher_title))
  end

  test "should show teacher_title" do
    get :show, id: @teacher_title
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teacher_title
    assert_response :success
  end

  test "should update teacher_title" do
    patch :update, id: @teacher_title, teacher_title: { name: @teacher_title.name }
    assert_redirected_to teacher_title_path(assigns(:teacher_title))
  end

  test "should destroy teacher_title" do
    assert_difference('TeacherTitle.count', -1) do
      delete :destroy, id: @teacher_title
    end

    assert_redirected_to teacher_titles_path
  end
end
