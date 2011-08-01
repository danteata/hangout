require 'spec_helper'

describe User do
  before (:each) do
    @attr = {:name =>"dantheta", :email=>"danteata@gmail.com", :password=>"userpassword", :password_confirmation=>"userpassword"}
  end

  it "should successfully create a user given valid attributes" do
    User.create!(@attr)
  end

  it "should not accept blank name strings" do
    no_name_user = User.new(@attr.merge(:name=>""))
    no_name_user.should_not be_valid
  end

  it "should not accept blank emails" do
    no_email_user = User.new(@attr.merge(:email=>""))
    no_email_user.should_not be_valid
  end

  it "should have a name of right length" do
    long_name = "a" * 31
    wrong_name_length_user = User.new(@attr.merge(:name=>long_name))
    wrong_name_length_user.should_not be_valid
  end

  it "should have a unique email" do
    User.create!(@attr)
    upcase_email = @attr[:email].upcase
    upcase_email_user = User.new(@attr.merge(:email =>upcase_email))
    upcase_email_user.should_not be_valid
  end

  describe "Password Validations" do
    it "should not accept blank passwords" do
      blank_password_user = User.new(@attr.merge(:password=>""))
      blank_password_user.should_not be_valid
    end
    it "should not accept shorter passwords" do
      short_password = "a" * 4
      short_password_user = User.new(@attr.merge(:password=>short_password, :password_confirmation=>short_password))
      short_password_user.should_not be_valid
    end

    it "should not accept longer passwords" do
      long_password = "a" * 41
      long_password_user = User.new(@attr.merge(:password=>long_password, :password_confirmation=>long_password))
      long_password_user.should_not be_valid
    end

    it "should not accept unmatched confirmations" do
      invalid_confirmation ="invalid"
      unconfirmed_password_user = User.new(@attr.merge(:password_confirmation=>invalid_confirmation))
      unconfirmed_password_user.should_not be_valid
    end
  end

  describe "Encrypted Password" do
    before (:each) do
      @user = User.create!(@attr)
    end

    it "should respond to encrypted password attribute" do
      @user.should respond_to :encrypted_password
    end

    it "should not have a blank encrypted password" do
      @user.encrypted_password.should_not be_blank
    end


    describe "has_password method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords do not match" do
        @user.has_password?("invalid").should be_false
      end

    end

    describe "authenticate method" do
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpassword")
        wrong_password_user.should be_nil
      end


      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("somename@somedomain.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end

    end
  end

  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin) #switch admin? value from false to true 
      @user.should be_admin
    end
  end

  describe "micropost associations" do
    before(:each) do
      @user = User.create!(@attr)
      @mp1 = Factory(:micropost, :user => @user,
                     :created_at => 1.day.ago)
      @mp2 = Factory(:micropost, :user => @user,
                     :created_at => 1.hour.ago)
    end

    it "should have a microposts attribute" do
      @user.should respond_to(:microposts)
    end

    it "should have the right micrposts in the right order" do
      @user.microposts.should == [@mp2, @mp1]
    end

    it "should destroy associated microposts" do
      @user.destroy
      [@mp1, @mp2].each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end

    it "should raise error when searching associated microposts with find method if destroyed" do
      @user.destroy
      [@mp1, @mp2].each do |micropost|
        lambda do
          Micropost.find(micropost.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
  describe "spec associaiton" do
    before(:each) do
      @user = User.create(@attr)
      @spec = Factory(:spec, :user => @user)
    end

    it "should have a spec attribute" do
      @user.should respond_to(:spec)
    end

    it "should destroy associated spec" do
      @user.destroy
      Spec.find_by_id(@spec.id).should be_nil
    end

    it "destroyed associated spec should raise error with find function" do
      lambda do
        @user.destroy
        Spec.find(@spec.id)
      end.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

end

