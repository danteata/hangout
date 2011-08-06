require 'spec_helper'

describe Spec do
  before(:each) do
    @user = Factory(:user)
    @attr = {:first_name =>"Foo", :last_name => "Bar"}
  end

  it "should create a new instance given right value" do
    @user.spec = Spec.new
    @user.spec.create!(@attr)
  end

  describe "user associations" do
    before(:each) do
      @user.spec = Spec.new
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

# == Schema Information
#
# Table name: specs
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  first_name :string(255)
#  last_name  :string(255)
#  gender     :string(255)
#  birthday   :date
#  occupation :string(255)
#  city       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

