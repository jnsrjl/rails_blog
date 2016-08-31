class SessionsController < ApplicationController

  def new

  end

  # Create a new session
  def create
    # Get submitted email and password
    address = params[:session][:email]
    password = params[:session][:password]

    # Pull the user from the db
    user = User.find_by(email: address.downcase)

    # User exists and password is correct
    if user && user.authenticate(password)
      # Login user
      create_session user

      # Show user profile page
      redirect_to user

    # There were invalid credentials
    else
      # Show an error message
      flash.now[:danger] = "You cocked up. Try again."

      # Show login page again
      render 'new'
    end
  end

  def destroy

  end
end
