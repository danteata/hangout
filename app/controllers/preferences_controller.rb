class PreferencesController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user

  def edit
    @user = User.find(params[:id]) #already defined in correct_user 
    @preference = @user.preference ||= Preference.new
    @title = "Edit Preference"
  end

  def show
    @title = "User Preference"
  end

  def update
    #@user = User.find(params[:id])
    @preference = @user.preference ||= Preference.new
    if @preference.update_attributes(params[:preference])
      flash[:success] = "Preferences saved successfully"
      redirect_to @user
    else
      @title = "Edit Preference"
      flash.now[:notice] = "Edit no work testing"
      render :edit
    end
  end

end
