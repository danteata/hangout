require 'spec_helper'

describe EmailsController do

  describe "GET 'remind'" do
    it "should be successful" do
      get 'remind'
      response.should be_success
    end
  end

end
