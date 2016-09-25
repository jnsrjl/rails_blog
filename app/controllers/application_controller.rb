class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Use these methods across the whole app
  include SessionsHelper

# Privates

  private

    # Returns true, if user has created a session
    def check_login_status
      # If user hasn't logged in
      unless logged_in?
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

      # Redirect to home page if wrong user or not admin
      unless @user == logged_in_user || logged_in_user.admin?
        redirect_to root_url
      end
    end
end
