class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @like = Like.new(author_id: @user.id, post_id: @post.id)
    return unless @like.save

    redirect_to user_posts_path(@user.id, @post)
  end
end
