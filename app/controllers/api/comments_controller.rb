class Api::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def create
    post = Post.find(params[:post_id])
    # @user = User.find(params[:user_id])
    comment = post.comments.new(comment_params)
    # comment.author = @user

    if comment.save
      render json: comment, status: :created
    else
      puts comment.errors.full_messages
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
