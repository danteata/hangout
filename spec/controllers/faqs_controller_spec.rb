require 'spec_helper'

describe FaqsController do
  render_views

  before(:each) do
    @user = Factory(:user)
    test_sign_in(@user)
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id => @user
      response.should be_success
    end
  end

end
