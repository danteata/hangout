module SessionsHelper
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil # getting rid of user 
  end

  def current_user= (user) #assigns user parameter to the user instance 
    @current_user = user
  end

  def current_user #returns the current user as he moves from page to page
    @current_user ||= user_from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  private

  def user_from_remember_token # returns user with the token or nil
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
end
