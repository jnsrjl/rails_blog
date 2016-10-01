class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @user = @post.blog.user
  end
end
