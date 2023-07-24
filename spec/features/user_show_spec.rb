require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before do
    @user1 = User.create(name: 'Mucha', posts_counter: 0)
    @user2 = User.create(name: 'Jeddah', posts_counter: 0)

    @user1.update(photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
    @user2.update(photo: 'https://unsplash.com/es/fotos/mEZ3PoFGs_k')
  end

  it 'displays the username of the user' do
    visit user_path(@user1)

    expect(page).to have_content('Mucha')
  end

  it 'displays the profile picture of the user' do
    visit user_path(@user1)

    expect(page).to have_css('.user-photo')
  end

  it 'displays the number of posts the user has written' do
    visit user_path(@user1)

    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end

  it 'redirects to the user show page when clicking on a user' do
    visit users_path

    click_link @user1.name

    expect(current_path).to eq(user_path(@user1))
    expect(page).to have_content(@user1.name)
  end
end
