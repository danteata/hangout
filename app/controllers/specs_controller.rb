class SpecsController < ApplicationController
  def new
    redirect_to users_path
  end

  def index
    redirect_to users_path
  end

  def show
  end

  def edit
    @title = "Edit specs"
  end


end
