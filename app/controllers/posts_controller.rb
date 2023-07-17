class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:author, comments: :author)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
  end
end
