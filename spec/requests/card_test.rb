require_relative "../test_helper"

class CardRequestTest < ActionDispatch::IntegrationTest
  test "POST /charge returns 200" do
    card = create(:card)
    product = create(:product)

    post charge_path, params: { card: { id: card.id, product_id: product.id } }

    assert_response :success
  end

  test "POST /charge returns unprocessable_entity if card does not exist" do
    product = create(:product)

    post charge_path, params: { card: { id: 99999, product_id: product.id } }

    assert_response :unprocessable_entity
    assert_equal({ error: "charge_failure", message: "Card with id #99999 not found" }, json)
  end
end
