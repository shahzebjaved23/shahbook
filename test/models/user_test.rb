require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "the friends ships" do
  	user = User.create(:someone)
  	user2 = User.create(:sometwo)
  	user.friends << user
  	assert user.friends.count > 0
  end

end
