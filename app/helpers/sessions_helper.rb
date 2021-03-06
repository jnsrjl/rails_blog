module SessionsHelper
  # Create a session for the user
  def create_session(user)
    # Add an encrypted user id to cookies which expires on browser close
    session[:user_id] = user.id
  end

  # Return current logged in user if exists
  def logged_in_user
    # If current user hasn't been defined
    if @logged_in_user.nil?
      # Find from db by session's user id
      @logged_in_user = User.find_by(id: session[:user_id])
    else
      # Define new
      @logged_in_user
    end
  end

  # Return true if user has logged in
  def logged_in?
    !logged_in_user.nil?
  end

  # Return true if param user is logged_in_user
  def logged_in_user?(current)
    current == logged_in_user
  end

  # Destroy current session of user
  def destroy_session
    session.delete(:user_id)
  end

  # Return logged in user's blog
  def myblog
    logged_in_user.blog
  end
end
