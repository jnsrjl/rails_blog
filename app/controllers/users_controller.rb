class UsersController < ApplicationController
  # Show user profile page based on id
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
      # Log the user in for convenience
      create_session(@user)

      # Show a welcome flash
      flash[:info] = "Hurray! You have successfully created a new blog."

      # Redirect to profile page
      redirect_to @user

    # Some parameters didn't pass
    else
      # Render new with error messages attached to @user
      render 'new'
    end
  end

  # Show user data editing form based on id
  def edit
    @user = User.find(params[:id])
  end

  # Update user data based on edit-form
  def update
    # Get user from db
    @user = User.find(params[:id])

    # User parameters passed validations
    if @user.update_attributes(user_strong_params)
      # Show message to indicate success
      flash[:info] = "User edit was successful"

      # Redirect to profile page
      redirect_to @user

    # Some aprameters didn't pass
    else
      # Render edit page with error messages attached to @user
      render 'edit'
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
