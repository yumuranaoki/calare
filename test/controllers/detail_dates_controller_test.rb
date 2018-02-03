require 'test_helper'

class DetailDatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get detail_dates_index_url
    assert_response :success
  end

end
