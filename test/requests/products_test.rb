require_relative "../test_helper"

class ProductsRequestTest < ActionDispatch::IntegrationTest
  test "GET /index returns 200" do
    get products_path
    assert_response :success
  end
end
