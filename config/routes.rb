Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users

  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[create]
    end
  end

  namespace :api, defaults: { format: :json } do
    resources :users, only: [] do
      resources :posts, only: [:index] do
        resources :comments, only: %i[index create]
      end
    end

    # resources :posts, only: [] do
    #   resources :comments, only: %i[index create]
    # end
  end
end
