class CommentsController < ApplicationController

  def create
    @user = User.find(params[:comment][:user_id]) #the user on whose wall the post was written 
    @comment = @user.comments.create!(:post_id => current_user.id, :content=>
                       params[:comment][:content])
    respond_to do |format|
      format.html {redirect_to profile_path(@user)}
      format.js
    end
    #redirect_to profile_path(@user) #redirecting to the user on whose wall content was posted. 

  end

  def destroy
    @comment = Comment.find(params[:id])
    @user = User.find(@comment.user_id)
    #@post = Post.find(@comment.post_id)
    @comment.destroy
    redirect_to profile_path(@user)
    #respond_with profile_path(@user)

    #respond_to do |format|
      #format.html {redirect_to profile_path(@user)}
      #format.js
    #end

  end

end
