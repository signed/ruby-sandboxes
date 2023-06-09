require "rails_helper"

RSpec.describe Api::MoonsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/moons").to route_to("api/moons#index")
    end

    it "routes to #show" do
      expect(get: "/api/moons/1").to route_to("api/moons#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/moons").to route_to("api/moons#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/moons/1").to route_to("api/moons#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/moons/1").to route_to("api/moons#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/moons/1").to route_to("api/moons#destroy", id: "1")
    end
  end
end
