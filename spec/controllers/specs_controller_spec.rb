require 'spec_helper'

describe SpecsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      #get :new
      #response.should redirect_to(users_path)
      pending
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
  end

end
