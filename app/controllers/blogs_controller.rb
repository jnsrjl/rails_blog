class BlogsController < ApplicationController

  # Show blog based on id
  def show
    @blog = Blog.find(params[:id])
    @user = @blog.user
  end
end
