class PostsController < ApplicationController

  def index

  end
  def show

  end

  def create
    @user = User.find(params[:post][:user_id]) #the user on whose wall the post was written 
    @user.posts.create!(:poster_id => current_user, :content=>
                       params[:post][:content])
    redirect_to profile_path(@user)

  end

  def destroy
    #@user = Post.find_by_user_id

  end

end
