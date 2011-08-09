class EmailsController < ApplicationController

  def remind
    @title = "Password Reminder"
    if param_posted?(:user)
      email = params[:user][:email]
      user = User.find_by_email(email)
      if user
        UserMailer.reminder(user).deliver
        flash[:success] = "Login information sent to #{email}"
        redirect_to root_path
      else
        flash[:error] = "There is no user the email #{email}"
      end
    end
  end

  def correspond
    @user = current_user
    @recipient = User.find(params[:id])
    @title = "Email #{@recipient.name}"
    @message ||= Message.new({:subject=>"", :body=>""})
    if param_posted?(:message)
      #if @message.update_attributes(params[:message])
      @message.subject = params[:message][:subject]
      @message.body = params[:message][:body]
      if @message.valid?
        UserMailer.correspond_mail(@recipient, @message, @user).deliver
        flash[:success] = "Email sent"
        redirect_to profile_path(@recipient)
      end
    end

  end

end
