class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comment_count

  # private

  def update_comment_count
    # post.increment!(:comments_count)
    post.update(comments_counter: post.comments.count)
  end
end
