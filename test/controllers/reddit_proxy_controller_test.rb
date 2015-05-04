require 'test_helper'

class RedditProxyControllerTest < ActionController::TestCase
  test "should get subreddits" do
    get :subreddits
    assert_response :success
  end

end
