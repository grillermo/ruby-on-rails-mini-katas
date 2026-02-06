require_relative "../test_helper"

class PayProductTest < ActiveSupport::TestCase
  test "call with valid card and product" do
    card = create(:card)
    product = create(:product)

    context = PayProduct.call(card_id: card.id, product_id: product.id)

    assert context.success?
    assert_equal product.cost, context.total_paid
  end
end
