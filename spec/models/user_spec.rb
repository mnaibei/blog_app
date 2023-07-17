require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      user = User.new
      user.valid?
      expect(user.errors.messages).to have_key(:name)
    end

    it 'validates numericality of posts_counter' do
      user = User.new(posts_counter: 'abc')
      user.valid?
      expect(user.errors[:posts_counter]).to include('is not a number')

      user.posts_counter = -1
      user.valid?
      expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')

      user.posts_counter = 0
      user.valid?
      expect(user.errors[:posts_counter]).to be_empty
    end
  end

  describe 'associations' do
    it 'has many posts' do
      user = User.create(name: 'John')
      post = Post.create(title: 'Title', text: 'Text', author: user)

      expect(post).to be_a(Post)
      expect(post.author).to eq(user)
    end

    it 'has many comments' do
      user = User.new(name: 'John')
      user.save
      post = Post.new(title: 'Title', text: 'Text')
      comment = post.comments.build(author: user)

      expect(comment).to be_a(Comment)
      expect(comment.author).to eq(user)
    end

    it 'has many likes' do
      user = User.new(name: 'John')
      user.save
      post = Post.new(title: 'Title', text: 'Text')
      like = post.likes.build(author: user)

      expect(like).to be_a(Like)
      expect(like.author).to eq(user)
    end
  end

  describe '#three_most_recent_posts' do
    let(:user) { create(:user) }

    it 'returns the three most recent posts' do
      user = User.create(name: 'name')
      first_post = Post.create(title: 'first post', text: 'text', author_id: user.id)
      Post.create(title: 'second post', text: 'text', author_id: user.id)
      Post.create(title: 'third post', text: 'text', author_id: user.id)
      Post.create(title: 'fourth post', text: 'text', author_id: user.id)
      expect(user.recent_posts).to_not include(first_post)
    end
  end
end
