class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  after_save :update_posts_count
  after_destroy :update_posts_counter

  def as_json(_options = {})
    { post_title: title, post_text: text, number_of_comments: comments_counter,
      number_of_likes: likes_counter, created_at:, updated_at: }
  end

  def five_most_recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end

  private

  def update_posts_count
    author.increment!(:posts_counter)
  end

  def update_posts_counter
    author.decrement!(:posts_counter)
  end
end
