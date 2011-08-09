class FaqsController < ApplicationController
  def index
    #redirect_to users_path
  end

  def new
    @title = "create spec"
    @user = User.find(params[:id])
    @user.spec = Spec.new
    @spec = @user.spec
  end

  def edit
    @title = "Edit FAQ"
    #@user = User.find(params[:id])
    @user = current_user
    @user.faq ||= Faq.new
    @faq = @user.faq

  end
  
  def create
    @user.faq ||=Faq.new
    if @user.faq.update_attributes(params[:faq])
      flash[:success] = "changes saved successfully"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def update
    #@user = User.find(params[:id])
    @user = current_user
    @user.faq ||= Faq.new(:user_id => @user.id)
    if @user.faq.update_attributes(params[:faq])
      flash[:success] = "Changes saved successfully"
      redirect_to @user
    else
      @title = "Edit faq"
      render 'edit'
    end
  end
end
