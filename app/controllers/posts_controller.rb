class PostsController < ApplicationController
  def index
    # @posts = Post.all
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:author, comments: :author)
  end

  def show
    @post = Post.includes(:author, comments: :author).find(params[:id])
    @user = @post.author
  end

  def new
    @post = Post.new
    @user = User.find(params[:user_id])
  end

  def create
    @post = Post.new(post_params)
    @user = User.find(params[:user_id])
    @post.author = current_user
    if @post.save
      redirect_to user_post_url(@user, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
