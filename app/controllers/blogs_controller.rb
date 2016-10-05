class BlogsController < ApplicationController

## Filters

  # Check session status for certain actions
  before_action :check_login_status, only: [:edit, :update]

  # Also check that the user is correct one
  before_action :check_blog_user, only: [:edit, :update]


## Actions

  # Show blog based on id
  def show
    # Fetch from db by url id
    @blog = Blog.find(params[:id])
    @user = @blog.user
    @posts = @blog.posts.paginate(page: params[:page], per_page: 3)
  end

  # Show all blogs with pagination
  def index
    # Change from default of 30 items per page to 5
    @blogs = Blog.paginate(page: params[:page], per_page: 5)
  end

  # Show blog data editing based on url
  def edit
    @blog = Blog.find(params[:id])
  end

  # Update blog data based on edit-form
  def update
    # Get blog from db
    @blog = Blog.find(params[:id])

    # User parameters passed validations
    if @blog.update_attributes(blog_strong_params)
      # Show message to indicate success
      flash[:info] = "Blog edit was successful"

      # Redirect to profile page
      redirect_to @blog

    # Some aprameters didn't pass
    else
      # Render edit page with error messages attached to @blog
      render 'edit'
    end
  end


## Privates

  private

    # Protect against form mass assignment
    # Returns only required and permitted parameters
    def blog_strong_params
      params.require(:blog).permit(:name)
    end

    # Return true if blog owner and accessing user match
    def check_blog_user
      # Fetch blog by id
      @blog = Blog.find(params[:id])

      # Redirect to home page if wrong user or not admin
      unless @blog.user == logged_in_user || logged_in_user.admin?
        redirect_to root_url
      end
    end
end
