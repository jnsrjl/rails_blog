class UsersController < ApplicationController
  def show

  end

  # Register form needs a user variable
  def new
    @user = User.new
  end

  # Submitting register-form calls for creation of a new user
  def create
    # Use private method to strongify parameters
    @user = User.new(user_strong_params)

    if @user.save
      #TODO
    else
      render 'new'
    end
  end


  ## Private area

  private

  # Returns only required and permitted parameters
  def user_strong_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
