class CardController < ApplicationController
  def charge
    result = PayProduct.call(charge_params)

    if result.success?
      render json: { success: true, message: result.message }
    else
      render json: { error: :charge_failure, message: result.message }, status: :unprocessable_entity
    end
  end

  private 

  def charge_params
    params.expect(card: [:id, :product_id])
  end
end
