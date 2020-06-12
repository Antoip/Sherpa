require 'test_helper'

class Teachers::FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get teachers_feedbacks_show_url
    assert_response :success
  end

end
