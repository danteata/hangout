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
  
  describe "GET signup" do
    it "should have signup page at /signup" do
      get "/signup"
      response.should have_selector("title", 
                                   :content=>"Sign Up")
    end
  end
end
