class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  after_save :update_posts_count

  def five_most_recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end

  private

  def update_posts_count
    author.increment!(:posts_counter)
  end
end
