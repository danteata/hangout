require 'spec_helper'

describe ProfilesController do
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

  describe "GET 'show'" do

    it "should be successful" do
      get 'show', :id =>@user
      response.should be_success
    end

    it "should have the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end

end
