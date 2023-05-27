require 'spec_helper'
require 'http_bin/http_bin_client'

describe HttpBin::Client do
  it 'POST anything echos passed json body in the response' do
    client = HttpBin::Client.new
    response = client.post_to_anything({ one: 'two' })

    expect(response['json']).to eq({ 'one' => 'two' })
  end
end