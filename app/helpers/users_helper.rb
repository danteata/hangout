module UsersHelper
  def gravatar_for(user, options = {:size=> 50}) 
    gravatar_image_tag(user.email.downcase, :alt =>user.name,
                                            :class => 'gravatar',
                                            :gravatar=>options)
  end

  #def submit_text 
    #@user.new_record? "Sign up" : "Edit"
  #end

  def submit_text
    unless @user.new_record?
      "Edit"
    else
      "Sign up"
    end

  end
end
