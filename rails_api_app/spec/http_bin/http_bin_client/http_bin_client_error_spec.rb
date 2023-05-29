require 'spec_helper'
require 'webmock/rspec'
require 'http_bin/http_bin_client'
require 'sinatra/base'
require "sinatra/json"

WebMock.disable_net_connect!(allow_localhost: true)

class FakeHttpBin < Sinatra::Base
  post '/anything' do
    status 500
  end

  # todo make the Fake configurable from outside to also use it for success case
  put '/anything' do
    status 200
    json({'json' => {'fake' => 'read this from the POST body'}})
  end

  private

  def route_missing
    raise "route not defined for #{request.request_method} #{uri} in #{self.class.name}."
  end
end

def url_to_regexp(url)
  %r(\A#{Regexp.escape url})
end

describe HttpBin::Client do
  it 'report :failed in case of unexpected status code with one-of webmock stub' do
    stub_request(:post, url_to_regexp('https://httpbin.org/anything')).
      to_return(status: 500, body: "stubbed response", headers: {})

    client = HttpBin::Client.new
    response = client.post_to_anything({ one: 'two' })

    expect(response).to eq(:failed)
  end

  it 'report :failed in case of unexpected status code with re-usable rack response' do
    WebMock.stub_request(:any, url_to_regexp('https://httpbin.org')).to_rack(FakeHttpBin)
    client = HttpBin::Client.new
    response = client.post_to_anything({ one: 'two' })

    expect(response).to eq(:failed)
  end

end


