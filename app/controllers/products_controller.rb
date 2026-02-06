class ProductsController < ApplicationController
  def index
    render json: {products: Product.to_json}
  end
end
