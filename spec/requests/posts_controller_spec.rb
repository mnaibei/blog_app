RSpec.describe PostsController, type: :request do
    describe 'GET #index' do
      it 'renders the posts template' do
        get '/users/1/posts'
        expect(response).to render_template('posts/index')
      end
  
      it 'returns a 200 OK status' do
        get '/users/1/posts'
        expect(response).to have_http_status(:ok)
      end
  
      it 'includes the correct placeholder text in the response body' do
        get '/users/1/posts'
        expect(response.body).to include('Here is a list of posts for a given user')
      end
    end
  
    describe 'GET #show_post' do
      it 'renders the show_post template' do
        get '/users/1/posts/1'
        expect(response).to render_template('posts/show')
      end
  
      it 'returns a 200 OK status' do
        get '/users/1/posts/1'
        expect(response).to have_http_status(:ok)
      end
  
      it 'includes the correct placeholder text in the response body' do
        get '/users/1/posts/1'
        expect(response.body).to include('Here is a list of posts for a given user')
      end
    end
  end