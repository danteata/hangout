class PostsController < ApplicationController

  def index

  end
  def show

  end

  def create
    @user = User.find(params[:post][:user_id]) #the user on whose wall the post was written 
    @user.posts.create!(:poster_id => current_user.id, :content=>
                       params[:post][:content])
    redirect_to profile_path(@user) #redirecting to the user on whose wall content was posted. 

  end

  def destroy
    #@user = Post.find_by_user_id

  end

end
