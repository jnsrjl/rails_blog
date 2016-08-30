module SessionsHelper
  # Create a session for the user
  def create_session(user)
    # Add an encrypted user id to cookies which expires on browser close
    session[:user_id] = user.id
  end
end
