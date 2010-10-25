require "spec_helper"

describe DesignsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/designs" }.should route_to(:controller => "designs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/designs/new" }.should route_to(:controller => "designs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/designs/1" }.should route_to(:controller => "designs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/designs/1/edit" }.should route_to(:controller => "designs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/designs" }.should route_to(:controller => "designs", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/designs/1" }.should route_to(:controller => "designs", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/designs/1" }.should route_to(:controller => "designs", :action => "destroy", :id => "1")
    end

  end
end
