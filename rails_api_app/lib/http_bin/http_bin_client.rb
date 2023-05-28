require 'faraday'

module HttpBin
  class Client
    def initialize
      @connection = Faraday.new(url: 'https://httpbin.org') do |f|
        f.request :json
        f.response :json
      end
    end

    def post_to_anything(body = {})
      response = @connection.post('/anything') do |req|
        req.body = body
      end
      case response.status
      when 200
        body = response.body
        {
          'json' => body['json']
        }
      else
        :failed
      end
    end
  end
end