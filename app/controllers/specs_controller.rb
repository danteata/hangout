class SpecsController < ApplicationController
  before_filter :authenticate 
  before_filter :correct_user, :except => [:index, :update, :new, :create]

  def new
    @title = "Create spec"
    @user = User.find(params[:id])
    @user.spec = Spec.new
    @spec = @user.spec
    #redirect_to users_path
  end

  def index
    redirect_to users_path
  end


  def edit
    @user = User.find(params[:id])
    @spec = @user.spec ||= Spec.new
    @title = "Edit specs"
  end

  #def edit
    #@title = "Edit spec"
    #@user = User.find(params[:id])
    #@user.spec ||= Spec.new(:user_id => @user.id)
    #@spec = @user.spec
    #if param_posted?(:spec)
      #if @user.spec.update_attributes(params[:spec])
        #flash[:notice] = "changes have been saved."
        #redirect_to @user
      #end
    #end
  #end

  def create
    @user = current_user
    @user.spec ||= Spec.new
    if @user.spec.update_attributes(params[:spec])
      flash[:success] = "changes saved successfully"
      redirect_to @user
    else
      @title = "Edit user again"
      render 'edit'
    end
  end

  def update
    #@user = User.find(params[:id])
    @user = current_user
    @spec = @user.spec ||= Spec.new
   if  @spec.update_attributes(params[:spec])
    flash[:success] = "Specs updated successfully"
    redirect_to @user
   else
     @title = "Edit user"
     render 'edit'
   end
  end

end
