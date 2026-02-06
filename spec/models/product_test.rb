require_relative "../test_helper"

class ProductTest < ActiveSupport::TestCase
  test "valid product" do
    product = build(:product)
    assert product.valid?
  end

  test "invalid without name" do
    product = build(:product, name: nil)
    assert_not product.valid?
    assert_includes product.errors[:name], "can't be blank"
  end

  test "invalid without cost" do
    product = build(:product, cost: nil)
    assert_not product.valid?
    assert_includes product.errors[:cost], "can't be blank"
  end
end
