require 'spec_helper'

describe "Users" do
  #describe "GET /users" do
  #it "works! (now write some real specs)" do
  ## Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #get users_index_path
  #response.status.should be(200)
  #end
  #end
  describe "signup" do
    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => ""
          fill_in "Email", :with => ""
          fill_in "Password", :with =>""
          fill_in "Confirmation", :with =>""
          click_button "Sign up"
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User,:count)
      end
    end

    describe "success" do
    
      it "should create a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with=>"dantheta"
          fill_in "Email", :with=>"dan@yahoo.com"
          fill_in "Password", :with=>"123456"
          fill_in "Confirmation", :with=>"123456"
          click_button "Sign up"
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end

    end
  end

  describe "sign in/out" do

    describe "failure" do

      it "should not sign a user in" do
        visit signin_path
        fill_in "Email", :with =>""
        fill_in "Password", :with =>""
        click_button "Sign in"
        response.should have_selector("div.flash.error", :content =>"Invalid")

      end
    end
    describe "success" do

      before(:each) do
        @user = Factory(:user)
      end

      it "should sign a user in" do
        #user = Factory(:user)
        visit signin_path
        fill_in :email, :with =>@user.email
        fill_in :password, :with => @user.password
        click_button "Sign in"
        controller.should be_signed_in
      end

      it "should sign a user in and out" do
        #user = Factory(:user)
        visit signin_path
        fill_in :email, :with =>@user.email
        fill_in :password, :with => @user.password
        click_button "Sign in"
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
