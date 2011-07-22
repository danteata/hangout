require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    

    it "should have sign up title at /signup" do
      get "new"
      response.should have_selector("title", 
                                   :content=>"Sign Up")
    end
  end

  describe "GET show" do
    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show, :id=> @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id=>@user
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get :show, :id=>@user
      response.should have_selector("title", :content=>"#{@user.name}")
    end

    it "should have the user's name" do
      get :show, :id=>@user
      response.should have_selector("h1", :content=> @user.name)
      
    end

    it "should have a profile image" do
      get :show, :id=>@user
      response.should have_selector("h1>img", :class => "gravatar")
    end
  
  end

  describe "POST 'create'" do

    describe "failure" do
      before(:each) do
        @attr = {:name =>"", :email=>"", :password=>"", :password_confirmation=>""}
        
      end

      it "should not create a user" do
        lambda do
          post :create, :user=>@attr
          
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user=>@attr
        response.should have_selector("title",:content => "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :user=>@attr
        response.should render_template('new')
      end
    end

    describe "success" do
      before(:each) do
        @attr ={:name=>"dantheta", :email=>"dan@yahoo.com",
                :password=>"123456", :password_confirmation=>"123456"}
      end

      it "should have a welcome message" do
        post :create, :user =>@attr
        flash[:success].should =~ /welcome to the network, dantheta/i
      end

      #it "should have a 'flash success' div " do 
        #post :create, :user=>@attr
        #response.should have_selector("div.flash.success", :content=>"Welcome")
      #end
      
      it "should create a user" do
        lambda do
          post :create, :user=> @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user =>@attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id=>@user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id =>@user
      response.should have_selector("title", :content => "Edit user")
    end

    it "should have a link to change the Gravatar" do
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      response.should have_selector("a", :href => gravatar_url,
                                         :content =>"change")
    end
  end

  
end
