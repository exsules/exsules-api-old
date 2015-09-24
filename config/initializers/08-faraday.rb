options = {
  request: {
    timeout: 25
  }
}

Faraday.default_connection = Faraday::Connection.new(options) do |b|
  b.use FaradayMiddleware::FollowRedirects, limit: 8
  b.use :cookie_jar
  b.adapter Faraday.default_adapter
end
