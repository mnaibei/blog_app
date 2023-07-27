class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comment_count
  after_destroy :update_comment_counter

  def as_json(_options = {})
    { comment: text, author: author.name } # NOT including the email field
  end

  private

  def update_comment_count
    post.increment!(:comments_counter)
  end

  def update_comment_counter
    post.decrement!(:comments_counter)
  end
end
