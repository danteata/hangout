require 'spec_helper'

describe "LayoutLinks" do

  describe "GET home" do 
    it "should have right title" do 
      get "/home"
      response.should have_selector("title",
                                          :content=>"Home")
    end
  end

  describe "GET about" do 
    it "should have right title" do
      get "/about"
      response.should have_selector("title", 
                                   :content=>"About")
    end
  end
  
end
