class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def as_json(_options = {})
    { name:, photo:, bio:, number_of_posts: posts_counter } # NOT including the email field
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def update_posts_counter
    update(posts_counter: posts.count)
  end
end
