require 'test_helper'

class Schoolfellow::TeachExperiencesControllerTest < ActionController::TestCase
  setup do
    @schoolfellow_teach_experience = schoolfellow_teach_experiences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schoolfellow_teach_experiences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create schoolfellow_teach_experience" do
    assert_difference('Schoolfellow::TeachExperience.count') do
      post :create, schoolfellow_teach_experience: { schoolfellow_id: @schoolfellow_teach_experience.schoolfellow_id, teach_end: @schoolfellow_teach_experience.teach_end, teach_start: @schoolfellow_teach_experience.teach_start, teacher_id: @schoolfellow_teach_experience.teacher_id, teacher_title_id: @schoolfellow_teach_experience.teacher_title_id }
    end

    assert_redirected_to schoolfellow_teach_experience_path(assigns(:schoolfellow_teach_experience))
  end

  test "should show schoolfellow_teach_experience" do
    get :show, id: @schoolfellow_teach_experience
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @schoolfellow_teach_experience
    assert_response :success
  end

  test "should update schoolfellow_teach_experience" do
    patch :update, id: @schoolfellow_teach_experience, schoolfellow_teach_experience: { schoolfellow_id: @schoolfellow_teach_experience.schoolfellow_id, teach_end: @schoolfellow_teach_experience.teach_end, teach_start: @schoolfellow_teach_experience.teach_start, teacher_id: @schoolfellow_teach_experience.teacher_id, teacher_title_id: @schoolfellow_teach_experience.teacher_title_id }
    assert_redirected_to schoolfellow_teach_experience_path(assigns(:schoolfellow_teach_experience))
  end

  test "should destroy schoolfellow_teach_experience" do
    assert_difference('Schoolfellow::TeachExperience.count', -1) do
      delete :destroy, id: @schoolfellow_teach_experience
    end

    assert_redirected_to schoolfellow_teach_experiences_path
  end
end
