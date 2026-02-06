class BooksController < ApplicationController
  def search
    client = OpenLibraryClient.new
    results = client.search(params[:q])
    render json: results
  rescue OpenLibraryUnavailable => e
    render json: { error: e.message }, status: :service_unavailable
  end
end
