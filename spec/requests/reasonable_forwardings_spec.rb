require 'spec_helper'

describe "ReasonableForwardings" do
  it "should forward to the requested page after signin" do
    user = Factory(:user)
    visit edit_user_path(user)
    #user will be redirected to signin page (authenticate filter)
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
    #should take user back to 1st attempt
    response.should render_template("users/_new_or_edit_form")
  end
end
