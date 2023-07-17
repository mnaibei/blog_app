class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @users = User.find(params[:id])
  end

  def posts
    @user = User.find(params[:user_id])
    @posts = @user.recent_posts
  end

  def show_post
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end
end
