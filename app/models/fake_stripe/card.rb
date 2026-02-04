module FakeStripe
  class Card
    def self.charge(card, product)
      OpenStruct.new(total_paid: product.cost)
    end
  end
end
