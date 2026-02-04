require 'rails_helper'

describe PayProduct, type: :interactor do 
  describe '.call' do
    let!(:card)  { create(:card) }
    let!(:product)  { create(:product) }

    subject(:context) { PayProduct.call(card_id: card.id, product_id: product.id) }

    context 'with a valid card and product' do
      it { expect(context).to be_a_success }

      it 'returns total paid the cost of the product' do
        expect(context.total_paid).to eql product.cost
      end
    end
  end
end

