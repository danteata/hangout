require 'spec_helper'

describe FaqsController do
  render_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      @user = test_sign_in(Factory(:user))
      get 'edit', :id => @user
      response.should be_success
    end
  end

end
