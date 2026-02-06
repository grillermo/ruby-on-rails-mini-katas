class ProductsController < ApplicationController
  def index
    StatsD.measure("products.index.time") do
      products_json = Rails.cache.fetch("products", expires_in: 2.minutes) do
        Product.to_json
      end

      render json: { products: products_json }
    end
  end
end
