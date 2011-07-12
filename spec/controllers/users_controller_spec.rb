require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "Get 'new'" do
    it "should have sign up title at /signup" do
      get "new"
      response.should have_selector("title", 
                                   :content=>"Sign Up")
    end
  end

end
