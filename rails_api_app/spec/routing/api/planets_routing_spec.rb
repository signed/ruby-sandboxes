require "rails_helper"

RSpec.describe Api::PlanetsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/planets").to route_to("api/planets#index")
    end

    it "routes to #show" do
      expect(get: "/api/planets/1").to route_to("api/planets#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/planets").to route_to("api/planets#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/planets/1").to route_to("api/planets#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/planets/1").to route_to("api/planets#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/planets/1").to route_to("api/planets#destroy", id: "1")
    end
  end
end
