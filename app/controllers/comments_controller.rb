class CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  load_and_authorize_resource

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.author = current_user

    if @comment.save
      redirect_to "/users/#{@user.id}/posts"
    else
      render 'posts/show'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to user_post_path(@post), notice: 'Comment was deleted succesfully'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
