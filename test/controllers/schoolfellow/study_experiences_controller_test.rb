require 'test_helper'

class Schoolfellow::StudyExperiencesControllerTest < ActionController::TestCase
  setup do
    @schoolfellow_study_experience = schoolfellow_study_experiences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schoolfellow_study_experiences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create schoolfellow_study_experience" do
    assert_difference('Schoolfellow::StudyExperience.count') do
      post :create, schoolfellow_study_experience: { attendance_date: @schoolfellow_study_experience.attendance_date, degree_id: @schoolfellow_study_experience.degree_id, graduated_date: @schoolfellow_study_experience.graduated_date, major_id: @schoolfellow_study_experience.major_id, schoolfellow_id: @schoolfellow_study_experience.schoolfellow_id, student_number: @schoolfellow_study_experience.student_number }
    end

    assert_redirected_to schoolfellow_study_experience_path(assigns(:schoolfellow_study_experience))
  end

  test "should show schoolfellow_study_experience" do
    get :show, id: @schoolfellow_study_experience
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @schoolfellow_study_experience
    assert_response :success
  end

  test "should update schoolfellow_study_experience" do
    patch :update, id: @schoolfellow_study_experience, schoolfellow_study_experience: { attendance_date: @schoolfellow_study_experience.attendance_date, degree_id: @schoolfellow_study_experience.degree_id, graduated_date: @schoolfellow_study_experience.graduated_date, major_id: @schoolfellow_study_experience.major_id, schoolfellow_id: @schoolfellow_study_experience.schoolfellow_id, student_number: @schoolfellow_study_experience.student_number }
    assert_redirected_to schoolfellow_study_experience_path(assigns(:schoolfellow_study_experience))
  end

  test "should destroy schoolfellow_study_experience" do
    assert_difference('Schoolfellow::StudyExperience.count', -1) do
      delete :destroy, id: @schoolfellow_study_experience
    end

    assert_redirected_to schoolfellow_study_experiences_path
  end
end
