module UsersHelper
  def gravatar_for(user, options = {:size=> 50}) 
    gravatar_image_tag(user.email.downcase, :alt =>user.name,
                                            :class => 'gravatar',
                                            :gravatar=>options)
  end

  def submit_text 
    @user.name.nil? ? "Sign up" : "Edit"
  end
end
