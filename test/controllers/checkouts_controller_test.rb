require "test_helper"

class CheckoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get checkouts_create_url
    assert_response :success
  end
end
