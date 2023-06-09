require 'rails_helper'
require 'http_bin/http_bin_client_fake'

describe Api::WorldController, type: :request do
  it 'GET /world' do
    get '/api/world'
    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body['name']).to eq('earth')
  end

  context 'GET /external_service' do
    it 'forward response from successful call' do
      fake_http_bin_client.call_succeeds

      get '/api/external_service'
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body).to eq('hello' => 'world')
    end

    it 'without a response from the external service we are out of business' do
      fake_http_bin_client.call_fails

      get '/api/external_service'
      expect(response).to have_http_status(503)
    end
  end
end

def fake_http_bin_client
  instance = HttpBin::ClientFake.new
  class_double = class_double(HttpBin::Client).as_stubbed_const(transfer_nested_constants: true)
  allow(class_double).to receive(:new).and_return(instance)
  return instance
end
