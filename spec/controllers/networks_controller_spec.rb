require 'spec_helper'

describe NetworksController do
  render_views

  before(:each) do
    @user = test_sign_in(Factory(:user))
  end

  describe "GET 'index'" do

    it "should be successful" do
      get :index
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
