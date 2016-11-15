require 'test_helper'

class FriendShipControllerTest < ActionController::TestCase
  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

end
