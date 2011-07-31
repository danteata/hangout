require 'spec_helper'

describe Spec do
  before(:each) do
    @user = Factory(:user)
    @attr = {:first_name =>"Foo", :last_name => "Bar"}
  end

  it "should create a new instance given right value" do
    @user.spec.create!(@attr)
  end

  describe "user associations" do
    before(:each) do
      @spec = @user.spec.create(@attr)
    end
    it "should have a related user" do
      @spec.should respond_to(:user)
    end

    it "should have the right associated user" do
      @spec.user_id.should == @user.id
      @spec.user.should == @user
    end
  end
end
