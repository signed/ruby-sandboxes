require "rails_helper"

RSpec.describe Api::StarsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/stars").to route_to("api/stars#index")
    end

    it "routes to #show" do
      expect(get: "/api/stars/1").to route_to("api/stars#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/stars").to route_to("api/stars#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/stars/1").to route_to("api/stars#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/stars/1").to route_to("api/stars#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/stars/1").to route_to("api/stars#destroy", id: "1")
    end
  end
end
