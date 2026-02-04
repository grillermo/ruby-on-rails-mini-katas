require 'rails_helper'

RSpec.describe "Cards", type: :request do
  describe "POST /charge" do
    let(:card) { create(:card) }
    let(:product) { create(:product) }

    subject { post(charge_path, params: {card: {id: card.id, product_id: product.id} }) }

    it 'returns 200' do
      subject
      expect(response).to have_http_status(:ok)
    end

    context 'if the card does not exists' do
      let(:card) { build(:card) }

      it 'returns unprocessable_entity' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eql({error: 'charge_failure', message: "Card with id # not found"})
      end
    end
  end
end
