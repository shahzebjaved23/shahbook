require 'test_helper'

class UserProfileControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get posts" do
    get :posts
    assert_response :success
  end

  test "should get photos" do
    get :photos
    assert_response :success
  end

  test "should get albums" do
    get :albums
    assert_response :success
  end

  test "should get friends" do
    get :friends
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
