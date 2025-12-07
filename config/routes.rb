Rails.application.routes.draw do
  devise_for :users

  root 'items#index'
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'users/:user_id/relationships' => 'relationships#create', as: 'relationships'
  delete 'users/:user_id/relationships' => 'relationships#destroy', as: 'relationship'

  get 'items/:item_id/likes' => 'likes#create', as: 'item_likes'
  delete 'items/:item_id/likes' => 'likes#destroy', as: 'item_like'

  get '/items/:item_id/orders/:order_id/exchanges' => 'exchanges#create'

  # get 'items/search_names', to: 'items#search_names'

  resources :users do
    resources :relationships, only: %i[create destroy]
  end

  resources :relationships, only: %i[create destroy]

  resources :items do
    resources :likes, only: %i[create destroy]
    collection do
      get :search_names
    end
    resources :orders, only: %i[index create show] do
      resources :exchanges, only: %i[create destroy]
    end
    resources :comments do
      resources :likes, only: %i[create destroy]

      resources :replies do
        resources :likes, only: %i[create destroy]
      end
    end
  end
end
