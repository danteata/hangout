class EmailsController < ApplicationController
  before_filter :authenticate, :except => "remind"


  #displays reminder form and sends user's login info via mail
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

  #display view for user to write message and send to other members
  def correspond
    @user = current_user
    @recipient = User.find(params[:id])
    @title = "Email #{@recipient.name}"
    if param_posted?(:original) #if user is responding to an original mail 
      # @original and @original_subject will be availabe in the correspond view
      @original_title = session[:original_title]
      @original_body = session[:original_subject]
    end

    @message ||= Message.new({:subject=>"", :body=>""})

    if param_posted?(:message)
      #if @message.update_attributes(params[:message])
      @message.subject = params[:message][:subject]
      @message.body = params[:message][:body]

      if @message.valid?
        #@body_sesson and @title_session will be available to mailer and it's correspond_message view
        @body_session = session[:original_message] #creating session in the controller 
        @title_session = session[:original_title]
        #passing message params including session instances to be accessible in action mailer
        UserMailer.correspond_mail(@user, @recipient, @message, 
                        @body_session, @title_session).deliver
        flash[:success] = "Email sent to #{@recipient.name}"
        redirect_to profile_path(@recipient)
      end
    end

  end

end
