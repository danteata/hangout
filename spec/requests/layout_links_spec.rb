require 'spec_helper'

describe "LayoutLinks" do

  describe "GET home" do 
    it "should have right title" do 
      get "/home"
      response.should have_selector("title",
                                    :content=>"Home")
    end
  end

  describe "GET about" do 
    it "should have right title" do
      get "/about"
      response.should have_selector("title", 
                                    :content=>"About")
    end
  end

  describe "GET signup" do
    it "should have signup page at /signup" do
      get "/signup"
      response.should have_selector("title", 
                                    :content=>"Sign Up")
    end
  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href=> signin_path,
                                    :content => "Sign in")
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in "Email", :with =>@user.email
      fill_in "Password", :with =>@user.password
      click_button
    end

    it "should hava a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path, 
                                          :content => "Sign out")
    end

    it "should hava a profile link" do
      visit root_path
      response.should have_selector("a", :href=>user_path(@user),
                                         :content => "Profile")
    end

  end
end
#end
