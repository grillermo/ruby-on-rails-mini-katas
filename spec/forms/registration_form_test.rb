require_relative "../test_helper"

class RegistrationFormTest < ActiveSupport::TestCase
  test "save with all arguments passed" do
    user_name = "Juan Paco Pedro"
    company_name = "De La mar"
    instance = RegistrationForm.new(user_name, company_name)

    assert_difference "User.count", 1 do
      assert_difference "Company.count", 1 do
        assert instance.save
      end
    end

    assert_equal user_name, User.last.name
  end

  test "save with missing arguments" do
    instance = RegistrationForm.new(nil, "")

    assert_no_difference "User.count" do
      assert_no_difference "Company.count" do
        assert_not instance.save
      end
    end

    assert_includes instance.message, "Validation failed: Name can't be blank"
  end
end
