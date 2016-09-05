class UsersController < ApplicationController
  # Check session status if user tries to access user edit or update -actions
  before_action :check_login_status, only: [:edit, :update]

  # Also check that the user is correct one
  before_action :check_user_correct, only: [:edit, :update]

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

##################################PRIVATES######################################

  private

    # Protect against form mass assignment
    # Returns only required and permitted parameters
    def user_strong_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end

    # Returns true, if user has created a session
    def check_login_status
      # If user hasn't logged in
      unless logged_in_user?
        # Show reminder message
        flash[:info] = "Log in to continue."

        # Redirect user to login page
        redirect_to login_url
      end
    end

    # Returns true, if user is the same as the user being accessed
    def check_user_correct
      # Fetch user by id
      @user = User.find(params[:id])

      # Redirect to home page if wrong user
      unless @user == logged_in_user
        redirect_to root_url
      end

    end
end
