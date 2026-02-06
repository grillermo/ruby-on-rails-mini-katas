class OpenLibraryUnavailable < StandardError; end

class OpenLibraryClient
  BASE_URL = "https://openlibrary.org"

  def initialize
    @connection = Faraday.new(url: BASE_URL) do |f|
      f.request :retry,
                max: 3,
                interval: 0.1,
                backoff_factor: 2,
                retry_statuses: [ 500, 502, 503, 504 ],
                exceptions: [
                  Faraday::TimeoutError,
                  Faraday::ConnectionFailed,
                  Faraday::RetriableResponse
                ]

      f.options.timeout = 2
      f.options.open_timeout = 2
      f.adapter Faraday.default_adapter
    end
  end

  def search(query)
    response = @connection.get("/search.json", { q: query })

    unless response.success?
      raise OpenLibraryUnavailable, "OpenLibrary API is unavailable (status #{response.status})"
    end

    JSON.parse(response.body)
  rescue Faraday::Error => e
    raise OpenLibraryUnavailable, "OpenLibrary API is unavailable: #{e.message}"
  end
end
