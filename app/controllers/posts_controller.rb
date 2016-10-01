class PostsController < ApplicationController

# Filters

  before_action :check_login_status, except: [:show, :index]
  before_action :check_post_user, only: [:edit, :update, :delete]

# Actions

  # Show post page based on url id
  def show
    @post = Post.find(params[:id])
    @user = @post.blog.user
  end

  # Post form needs a new object
  def new
    @post = Post.new
  end

  # Try to save the new post
  def create
    # Associate with logged in user and use strong parameters
    @post = logged_in_user.blog.posts.build(post_strong_params)

    # If post params pass validations
    if @post.save
      # Show success message on next request
      flash[:info] = "New post created!"

      # Redirect to created post
      redirect_to @post

    # Some parameters didn't pass
    else
      # Render new with error messages attached to @post
      render 'new'
    end
  end


# Privates

  private

    # Protect against form mass assignment
    # Returns only required and permitted parameters
    def post_strong_params
      params.require(:post).permit(:title, :content)
    end

    # Return true if post owner and accessing user match
    def check_post_user
      # Fetch post by id
      @post = Post.find(params[:id])

      # Redirect to home page if wrong user or not admin
      unless @post.blog.user == logged_in_user || logged_in_user.admin?
        redirect_to root_url
      end
    end

end
