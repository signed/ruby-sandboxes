require 'http_bin/http_bin_client'

class WorldController < ApplicationController
  def show
    render status: :ok, json: { name: 'earth' }
  end

  def external_service
    client = HttpBin::Client.new
    response = client.post_to_anything({ hello: 'world' })

    case response
    when :failed
      return render status: :service_unavailable
    else
      return render status: :ok, json: response['json']
    end
  end
end