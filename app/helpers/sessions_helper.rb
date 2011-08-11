module SessionsHelper

  def sign_in(user)
    #creates a secure digital signature using the user's id and salt which expire 20years.
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def sign_out
    cookies.delete(:remember_token) #clear the remember_token hash from cookies 
    self.current_user = nil # uses ruby assignment syntax to assign @current_user to nil 
  end

  #ruby assignment syntax..assigns parameter (user) to @current_user
  def current_user= (user) #assigns user parameter to the user instance 
    @current_user = user
  end

  def current_user #returns the current user as he moves from page to page
    @current_user ||= user_from_remember_token
  end

  #returns true if there is a current_user (signed in) on the platform
  def signed_in?
    !current_user.nil?
  end

  #returns true if given user object is the same as user currently logged in
  def current_user?(user)
    user == current_user
  end

  def deny_access
    flash[:notice] = "Please sign in to access this page"
    redirect_to signin_path
  end

  #all methods under private are exactly so..lol
  private

    def user_from_remember_token # returns user with the token or nil
      User.authenticate_with_salt(*remember_token) #* attached to param changes the 2 element array to 2 params 
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
