class UsersController < ApplicationController

# Filters

  # Check session status for certain actions
  before_action :check_login_status, only: [:show, :index, :edit, :update, :destroy]

  # Also check that the user is correct one
  before_action :check_user_correct, only: [:show, :edit, :update, :destroy]

  # Restrict index to admins
  before_action :check_admin, only: :index

# Actions

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

  # Show all users with pagination
  def index
    # Change from default of 30 items per page to 5
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  # Kill a user
  def destroy
    # Fetch the right dude
    sentenced = User.find(params[:id])

    # Save name for message
    name = sentenced.name

    # Commit murder
    sentenced.destroy

    # Show message of successful murder
    flash[:info] = "You successfully murdered " + name

    # Back to index
    redirect_to users_url
  end

# Privates

  private

    # Protect against form mass assignment
    # Returns only required and permitted parameters
    def user_strong_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end

    # Returns true, if user is with admin status
    def check_admin
      unless logged_in_user.admin?
        redirect_to(root_url)
      end
    end
end
