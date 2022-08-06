require 'test_helper'

class ToppageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get toppage_home_url
    assert_response :success
  end

end
