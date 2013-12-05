require "spec_helper"

describe HousingsController do
  describe "routing" do

    it "routes to #index" do
      get("/housings").should route_to("housings#index")
    end

    it "routes to #new" do
      get("/housings/new").should route_to("housings#new")
    end

    it "routes to #show" do
      get("/housings/1").should route_to("housings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/housings/1/edit").should route_to("housings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/housings").should route_to("housings#create")
    end

    it "routes to #update" do
      put("/housings/1").should route_to("housings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/housings/1").should route_to("housings#destroy", :id => "1")
    end

  end
end
