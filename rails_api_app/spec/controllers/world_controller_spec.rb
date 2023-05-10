require 'rails_helper'

describe WorldController, type: :request do
  it 'GET /world' do
    get '/world'
    body = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(body['name']).to eq('earth')
  end
end