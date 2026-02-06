require_relative "../test_helper"

class OpenLibraryClientTest < ActiveSupport::TestCase
  def setup
    @client = OpenLibraryClient.new
    @search_url = "https://openlibrary.org/search.json"
  end

  test "search returns parsed JSON on success" do
    stub_request(:get, @search_url)
      .with(query: { q: "the lord of the rings" })
      .to_return(
        status: 200,
        body: '{"docs": [{"title": "The Lord of the Rings"}]}',
        headers: { 'Content-Type' => 'application/json' }
      )

    result = @client.search("the lord of the rings")
    assert_equal "The Lord of the Rings", result["docs"].first["title"]
  end

  test "search raises OpenLibraryUnavailable on 500 error after retries" do
    stub_request(:get, @search_url)
      .with(query: { q: "fail" })
      .to_return(status: 500)

    assert_raises(OpenLibraryUnavailable) do
      @client.search("fail")
    end

    # 1 initial + 3 retries = 4 calls
    assert_requested(:get, @search_url, query: { q: "fail" }, times: 4)
  end

  test "search raises OpenLibraryUnavailable on timeout after retries" do
    stub_request(:get, @search_url)
      .with(query: { q: "timeout" })
      .to_timeout

    assert_raises(OpenLibraryUnavailable) do
      @client.search("timeout")
    end

    assert_requested(:get, @search_url, query: { q: "timeout" }, times: 4)
  end

  test "search raises OpenLibraryUnavailable on connection failure" do
    stub_request(:get, @search_url)
      .with(query: { q: "conn_fail" })
      .to_raise(Faraday::ConnectionFailed.new("Connection failed"))

    assert_raises(OpenLibraryUnavailable) do
      @client.search("conn_fail")
    end
  end
end
