require "test_helper"

class MuchoWelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mucho_welcome_index_url
    assert_response :success
  end
end
