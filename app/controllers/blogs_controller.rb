class BlogsController < ApplicationController

# Filters

  # Check session status for certain actions
  before_action :check_login_status, only: [:new, :create, :edit, :update, :destroy]

  # Also check that the user is correct one
  before_action :check_user_correct, only: [:create, :update, :destroy]


# Actions

  # Show blog based on id
  def show
    # Fetch from db by url id
    @blog = Blog.find(params[:id])
    @user = @blog.user
  end

  # Show all blogs with pagination
  def index
    # Change from default of 30 items per page to 5
    @blogs = Blog.paginate(page: params[:page], per_page: 5)
  end
end
