class PayProduct
  include Interactor

  def call
    load_card
    load_product
    charge_card
  end

  private

  def charge_card
    payment = FakeStripe::Card.charge(context.card, context.product)

    context.total_paid = payment.total_paid
    context.message = "Charged #{payment.total_paid}"
  end

  def load_product
    context.product = Product.find(context.product_id)
  rescue ActiveRecord::RecordNotFound
    context.fail!(message: "Product with id ##{context.product_id} not found")
  end

  def load_card
    context.card = Card.find(context.card_id)
  rescue ActiveRecord::RecordNotFound
    context.fail!(message: "Card with id ##{context.id} not found")
  end
end
