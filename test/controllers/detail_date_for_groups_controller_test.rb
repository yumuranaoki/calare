require 'test_helper'

class DetailDateForGroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get detail_date_for_groups_index_url
    assert_response :success
  end

end
