require 'spec_helper'

describe PreferencesController do
  render_views

  before(:each) do
    @user = Factory(:user)
    test_sign_in(@user)
  end
  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id=>@user
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show', :id=>@user
      response.should be_success
    end
  end

end
