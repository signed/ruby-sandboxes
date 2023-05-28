require 'spec_helper'
require 'webmock/rspec'
require 'http_bin/http_bin_client'

describe HttpBin::Client do
  it 'report :failed in case of unexpected status code' do
    WebMock.disable_net_connect!(allow_localhost: true)
    stub_request(:post, /httpbin.org/).
      to_return(status: 500, body: "stubbed response", headers: {})

    client = HttpBin::Client.new
    response = client.post_to_anything({ one: 'two' })

    expect(response).to eq(:failed)
  end
end