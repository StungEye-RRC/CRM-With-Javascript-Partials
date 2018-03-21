require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customers_index_url
    assert_response :success
  end

  test "should get show" do
    get customers_show_url
    assert_response :success
  end

  test "should get missing_email" do
    get customers_missing_email_url
    assert_response :success
  end

end
