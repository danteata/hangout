class PostsController < ApplicationController

  def index

  end
  def show

  end

  def create
    @user = User.find(params[:post][:user_id]) #the user on whose wall the post was written 
    @post = @user.posts.create!(:poster_id => current_user.id, :content=>
                       params[:post][:content])
    respond_to do |format|
      format.html {redirect_to profile_path(@user)}
      format.js
    end
    #redirect_to profile_path(@user) #redirecting to the user on whose wall content was posted. 

  end

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(@post.poster_id)
    @post.destroy
    respond_to do |format|
      format.html {redirect_to profile_path(@user)}
      format.js
    end

  end

end
