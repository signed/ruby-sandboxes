require 'rails_helper'

RSpec.describe "/api/planets", type: :request do
  let(:star) { create(:star) }
  let(:valid_attributes) {
    { name: 'earth', radius: 6371, star_id: star.id }
  }

  let(:invalid_attributes) {
    { name: 42 }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Planet.create! valid_attributes
      get api_planets_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      planet = Planet.create! valid_attributes
      get api_planet_url(planet), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Planet" do
        expect {
          post api_planets_url,
               params: { planet: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Planet, :count).by(1)
      end

      it "renders a JSON response with the new planet" do
        post api_planets_url,
             params: { planet: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Planet" do
        expect {
          post api_planets_url,
               params: { planet: invalid_attributes }, as: :json
        }.to change(Planet, :count).by(0)
      end

      it "renders a JSON response with errors for the new planet" do
        post api_planets_url,
             params: { planet: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'updated planet name' }
      }

      it "updates the requested planet" do
        planet = Planet.create! valid_attributes
        patch api_planet_url(planet),
              params: { planet: new_attributes }, headers: valid_headers, as: :json
        planet.reload
        expect(planet.name).to eq('updated planet name')
      end

      it "renders a JSON response with the planet" do
        planet = Planet.create! valid_attributes
        patch api_planet_url(planet),
              params: { planet: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the planet" do
        planet = Planet.create! valid_attributes
        patch api_planet_url(planet),
              params: { planet: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested planet" do
      planet = Planet.create! valid_attributes
      expect {
        delete api_planet_url(planet), headers: valid_headers, as: :json
      }.to change(Planet, :count).by(-1)
    end
  end
end
