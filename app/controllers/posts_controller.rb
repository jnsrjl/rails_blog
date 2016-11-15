class PostsController < ApplicationController

# Filters

  before_action :check_login_status, except: [:show, :index]
  before_action :check_post_user, only: [:edit, :update, :destroy]

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

  # Try to create a new post
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

  # Show edit page based on url id
  def edit
    @post = Post.find(params[:id])
  end

  # Try to update post data based on edit-form
  def update
    # Get post from db
    @post = Post.find(params[:id])

    # Post parameters passed validations
    if @post.update_attributes(post_strong_params)
      # Show message to indicate success
      flash[:info] = "Post edit was successful"

      # Redirect to post page
      redirect_to @post

    # Some parameters didn't pass
    else
      # Render edit page with error messages attached to @post
      render 'edit'
    end
  end

  # Kill a blog post
  def destroy
    # Fetch the right post
    sentenced = Post.find(params[:id])

    # Save title for message and blog for redirect
    title = sentenced.title
    blog = sentenced.blog

    # Commit murder
    sentenced.destroy

    # Show message of successful murder
    flash[:info] = "You successfully destroyed blog post: " + title

    # Back to index
    redirect_to blog_path(blog)
  end

  # Show all blog posts with pagination
  def index
    @posts = Post.paginate(page: params[:page])
  end


# Privates

  private

    # Protect against form mass assignment
    # Returns only required and permitted parameters
    def post_strong_params
      params.require(:post).permit(:title, :content, :image)
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
