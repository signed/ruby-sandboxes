require 'rails_helper'

RSpec.describe "/api/moons", type: :request do
  let(:valid_attributes) {
    earth = create(:planet, :earth)
    { name: 'The moon', radius: 1737, planet_id: earth.id }
  }

  let(:invalid_attributes) {
    { name: '', radius: 0, planet_id: -1 }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Moon.create! valid_attributes
      get api_moons_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      moon = Moon.create! valid_attributes
      get api_moon_url(moon), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Moon" do
        expect {
          post api_moons_url,
               params: { moon: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Moon, :count).by(1)
      end

      it "renders a JSON response with the new moon" do
        post api_moons_url,
             params: { moon: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Moon" do
        expect {
          post api_moons_url,
               params: { moon: invalid_attributes }, as: :json
        }.to change(Moon, :count).by(0)
      end

      it "renders a JSON response with errors for the new moon" do
        post api_moons_url,
             params: { moon: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'updated name' }
      }

      it "updates the requested moon" do
        moon = Moon.create! valid_attributes
        patch api_moon_url(moon),
              params: { moon: new_attributes }, headers: valid_headers, as: :json
        moon.reload
        expect(moon.name).to eq('updated name')
      end

      it "renders a JSON response with the moon" do
        moon = Moon.create! valid_attributes
        patch api_moon_url(moon),
              params: { moon: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the moon" do
        moon = Moon.create! valid_attributes
        patch api_moon_url(moon),
              params: { moon: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested moon" do
      moon = Moon.create! valid_attributes
      expect {
        delete api_moon_url(moon), headers: valid_headers, as: :json
      }.to change(Moon, :count).by(-1)
    end
  end
end
