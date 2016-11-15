require 'test_helper'

class BiosControllerTest < ActionController::TestCase
  setup do
    @bio = bios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bio" do
    assert_difference('Bio.count') do
      post :create, bio: { college: @bio.college, college_cert: @bio.college_cert, designation: @bio.designation, home_town: @bio.home_town, school: @bio.school, school_cert: @bio.school_cert, university: @bio.university, university_degree: @bio.university_degree, work_place: @bio.work_place }
    end

    assert_redirected_to bio_path(assigns(:bio))
  end

  test "should show bio" do
    get :show, id: @bio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bio
    assert_response :success
  end

  test "should update bio" do
    patch :update, id: @bio, bio: { college: @bio.college, college_cert: @bio.college_cert, designation: @bio.designation, home_town: @bio.home_town, school: @bio.school, school_cert: @bio.school_cert, university: @bio.university, university_degree: @bio.university_degree, work_place: @bio.work_place }
    assert_redirected_to bio_path(assigns(:bio))
  end

  test "should destroy bio" do
    assert_difference('Bio.count', -1) do
      delete :destroy, id: @bio
    end

    assert_redirected_to bios_path
  end
end
