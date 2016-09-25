class BlogsController < ApplicationController

# Filters

  # Check session status for certain actions
  before_action :check_login_status, only: [:new, :create, :edit, :update, :destroy]

  # Also check that the user is correct one
  before_action :check_user_correct, only: [:new, :create, :edit, :update, :destroy]


# Actions

  # Show blog based on id
  def show
    # Fetch from db by url id
    @blog = Blog.find(params[:id])
    @user = @blog.user
  end

  # Register form needs a blog object linked to user
  def new
    @blog = logged_in_user.build_blog
  end

end
