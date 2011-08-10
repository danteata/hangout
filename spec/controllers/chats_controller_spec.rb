require 'spec_helper'

describe ChatsController do
  render_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'send_data'" do
    it "should be successful" do
      get 'send_data'
      response.should be_success
    end
  end

end
