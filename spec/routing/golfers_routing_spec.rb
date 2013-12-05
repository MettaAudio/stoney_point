require "spec_helper"

describe GolfersController do
  describe "routing" do

    it "routes to #index" do
      get("/golfers").should route_to("golfers#index")
    end

    it "routes to #new" do
      get("/golfers/new").should route_to("golfers#new")
    end

    it "routes to #show" do
      get("/golfers/1").should route_to("golfers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/golfers/1/edit").should route_to("golfers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/golfers").should route_to("golfers#create")
    end

    it "routes to #update" do
      put("/golfers/1").should route_to("golfers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/golfers/1").should route_to("golfers#destroy", :id => "1")
    end

  end
end
