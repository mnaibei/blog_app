require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get users_path(1)
      expect(response.body).to include('Here is a list of users')
    end
  end
end
