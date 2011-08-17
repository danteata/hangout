require 'spec_helper'

describe PostsController do
  before(:each) do
    @user = test_sign_in(Factory(:user))
    @poster = test_sign_in(Factory(:user, :email=>"poster@meltwater.org"))
    
  end
  describe "Create" do
    it "should create a new post using ajax" do
      xhr :post, :create, :post =>{:poster_id =>@poster}
      response.should be_success
    end.should change(Post, :count).by(1)
  end

end
