require_relative "../test_helper"

class BooksRequestTest < ActionDispatch::IntegrationTest
  test "GET /books/search returns books from OpenLibrary" do
    query = "lord of the rings"
    stub_request(:get, "https://openlibrary.org/search.json")
      .with(query: { q: query })
      .to_return(
        status: 200,
        body: '{"docs": [{"title": "The Lord of the Rings"}]}',
        headers: { 'Content-Type' => 'application/json' }
      )

    get books_search_path, params: { q: query }

    assert_response :success
    assert_equal "The Lord of the Rings", json[:docs].first[:title]
  end

  test "GET /books/search returns 503 if OpenLibrary is unavailable" do
    query = "fail"
    stub_request(:get, "https://openlibrary.org/search.json")
      .with(query: { q: query })
      .to_return(status: 500)

    get books_search_path, params: { q: query }

    assert_response :service_unavailable
    assert_includes json[:error], "OpenLibrary API is unavailable"
  end
end
