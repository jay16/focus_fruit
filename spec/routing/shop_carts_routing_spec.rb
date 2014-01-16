require "spec_helper"

describe ShopCartsController do
  describe "routing" do

    it "routes to #index" do
      get("/shop_carts").should route_to("shop_carts#index")
    end

    it "routes to #new" do
      get("/shop_carts/new").should route_to("shop_carts#new")
    end

    it "routes to #show" do
      get("/shop_carts/1").should route_to("shop_carts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/shop_carts/1/edit").should route_to("shop_carts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/shop_carts").should route_to("shop_carts#create")
    end

    it "routes to #update" do
      put("/shop_carts/1").should route_to("shop_carts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/shop_carts/1").should route_to("shop_carts#destroy", :id => "1")
    end

  end
end
