require 'spec_helper'

describe Micropost do
  before(:each) do
    @user = Factory(:user)
    @attr = {:content => "some micropost content"}
  
  end

  describe "create" do
    it "should create a new instance " do
      @user.microposts.create!(@attr)

    end
  end

  describe "user associations" do
    before(:each) do
      @micropost = @user.microposts.build(@attr)

    end

    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user.should == @user
      @micropost.user_id.should == @user.id
    end
  end

  describe "validations" do
    it "should require a user id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.microposts.build(:content =>" ").should_not be_valid
    end

    it "should reject long content" do
      @user.microposts.build(:content => "a" * 256).should_not be_valid
    end
  end
end
