class PagesController < ApplicationController
  def home
    @title = "Home"
    if current_user
      redirect_to users_path
    else
      redirect_to signin_path
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end
end
