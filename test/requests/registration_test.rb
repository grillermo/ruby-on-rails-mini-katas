require_relative "../test_helper"

class RegistrationRequestTest < ActionDispatch::IntegrationTest
  test "POST /register returns 200 and creates user and company" do
    assert_difference [ "User.count", "Company.count" ], 1 do
      post register_path, params: { user_name: 'wow', company_name: 'coke' }
    end

    assert_response :success
  end
end
