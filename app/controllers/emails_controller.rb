class EmailsController < ApplicationController

  def remind
    @title = "Password Reminder"
    if param_posted?(:user)
      email = params[:user][:email]
      user = User.find_by_email(email)
      if user
        UserMailer.reminder(user).deliver
        flash[:notice] = "Login information sent to #{email}"
        redirect_to root_path
      else
        flash[:notice] = "There is no user the email #{email}"
      end
    end
  end

end
