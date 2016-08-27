class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  # Register form needs a user variable
  def new
    @user = User.new
  end

  # Submitting register-form calls for creation of a new user
  def create
    # Use private method to strongify parameters
    @user = User.new(user_strong_params)

    # User parameters passed validations
    if @user.save
      # TEMP : Redirect to profile page for now : later to blog front
      redirect_to @user

    # Some parameters didn't pass
    else
      # Render new with error messages attached to @user
      render 'new'
    end
  end


  private

  # Protect against form parameter forgery
  # Returns only required and permitted parameters
  def user_strong_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
