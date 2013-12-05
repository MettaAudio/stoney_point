require "spec_helper"

describe WorkDaysController do
  describe "routing" do

    it "routes to #index" do
      get("/work_days").should route_to("work_days#index")
    end

    it "routes to #new" do
      get("/work_days/new").should route_to("work_days#new")
    end

    it "routes to #show" do
      get("/work_days/1").should route_to("work_days#show", :id => "1")
    end

    it "routes to #edit" do
      get("/work_days/1/edit").should route_to("work_days#edit", :id => "1")
    end

    it "routes to #create" do
      post("/work_days").should route_to("work_days#create")
    end

    it "routes to #update" do
      put("/work_days/1").should route_to("work_days#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/work_days/1").should route_to("work_days#destroy", :id => "1")
    end

  end
end
