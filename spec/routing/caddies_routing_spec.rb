require "spec_helper"

describe CaddiesController do
  describe "routing" do

    it "routes to #index" do
      get("/caddies").should route_to("caddies#index")
    end

    it "routes to #new" do
      get("/caddies/new").should route_to("caddies#new")
    end

    it "routes to #show" do
      get("/caddies/1").should route_to("caddies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/caddies/1/edit").should route_to("caddies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/caddies").should route_to("caddies#create")
    end

    it "routes to #update" do
      put("/caddies/1").should route_to("caddies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/caddies/1").should route_to("caddies#destroy", :id => "1")
    end

  end
end
