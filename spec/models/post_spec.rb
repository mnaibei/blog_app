require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John') }

  describe 'validations' do
    it 'requires a title' do
      post = Post.new(author: user, title: '', text: 'Post Text')
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'limits the maximum length of the title to 250 characters' do
      long_title = 'a' * 251
      post = Post.new(author: user, title: long_title, text: 'Post Text')
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates the numericality of comments_counter' do
      post = Post.new(author: user, title: 'Post Title', text: 'Post Text', comments_counter: -1)
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'validates the numericality of likes_counter' do
      post = Post.new(author: user, title: 'Post Title', text: 'Post Text', likes_counter: -1)
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe '#five_most_recent_likes' do
    it 'returns the five most recent posts' do
      user = User.create(name: 'name')
      first_post = Post.create(title: 'first post', text: 'text', author_id: user.id)
      first_comment = Comment.create(text: 'text', author_id: user.id, post_id: first_post.id)
      Comment.create(text: 'text', author_id: user.id, post_id: first_post.id)
      Comment.create(text: 'text', author_id: user.id, post_id: first_post.id)
      Comment.create(text: 'text', author_id: user.id, post_id: first_post.id)
      Comment.create(text: 'text', author_id: user.id, post_id: first_post.id)
      Comment.create(text: 'text', author_id: user.id, post_id: first_post.id)
      expect(first_post.five_most_recent_comments).to_not include(first_comment)
    end
  end
end
