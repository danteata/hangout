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

  def correspond
    @user = current_user
    @recipient = User.find(params[:id])
    @title = "Email #{@recipient.name}"
    if param_posted?(:message)
      @message = Message.new(params[:message])
      if @message.valid?
        UserMailer.message(@user, @recipient, @message).deliver
        flash[:notice] = "Email sent"
        redirect_to profile_for(@recipient)
      end
    end

  end

end
