class ProductsController < ApplicationController
  def index
    StatsD.measure("products.index.time") do
      render json: { products: Product.to_json }
    end
  end
end
