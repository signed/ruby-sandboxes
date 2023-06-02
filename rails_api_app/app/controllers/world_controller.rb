require 'http_bin/http_bin_client'

class WorldController < ApplicationController
  def show
    render status: :ok, json: { name: 'earth' }
  end

  def logger_example
    SemanticLogger.push_tags 'bongo2'
    Rails.logger.info { 'banana bread' }
    Rails.logger.info('The message',
                      duration: 42,
                      result:   'fun',
                      table:    'users',
                      action:   'query')
    Rails.logger.info { { one: 1, two: 2 } }
    Rails.logger.error('wups', StandardError.new('this went wrong'))
    data = { boom: 'cake', flavour: 'explosion', b: 'bbbbb' }
    Rails.logger.info('boom', data)
    Rails.logger.info('boom', boom: 'cake', flavour: 'explosion', b: 'bbbbb')
    render status: :ok
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