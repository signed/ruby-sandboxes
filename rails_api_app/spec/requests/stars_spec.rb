require 'rails_helper'

RSpec.describe "/api/stars", type: :request do
  let(:valid_attributes) { { name: 'sun', radius: 695700 } }
  let(:invalid_attributes) { { bogus: 'value', radius: 0} }
  let(:valid_headers) { {} }

  describe "GET /index" do
    it "renders a successful response" do
      Star.create! valid_attributes
      get api_stars_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      star = Star.create! valid_attributes
      get api_stars_url(star), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Star" do
        expect {
          post api_stars_url,
               params: { star: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Star, :count).by(1)
      end

      it "renders a JSON response with the new star" do
        post api_stars_url,
             params: { star: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Star" do
        expect {
          post api_stars_url,
               params: { star: invalid_attributes }, as: :json
        }.to change(Star, :count).by(0)
      end

      it "renders a JSON response with errors for the new star" do
        post api_stars_url,
             params: { star: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { name: 'new name'} }

      it "updates the requested star" do
        star = Star.create! valid_attributes
        patch api_star_url(star),
              params: { star: new_attributes }, headers: valid_headers, as: :json
        star.reload
        expect(JSON.parse(response.body, symbolize_names: true)).to include(name: 'new name')
      end

      it "renders a JSON response with the star" do
        star = Star.create! valid_attributes
        patch api_star_url(star),
              params: { star: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the star" do
        star = Star.create! valid_attributes
        patch api_star_url(star),
              params: { star: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested star" do
      star = Star.create! valid_attributes
      expect {
        delete api_star_url(star), headers: valid_headers, as: :json
      }.to change(Star, :count).by(-1)
    end
  end
end
