Rails.application.routes.draw do
  devise_for :users

  root 'items#index'
  # get 'up' => 'rails/health#show', as: :rails_health_check

  get 'users/:id/relationships' => 'relationships#create', as: 'user_relationships'
  delete 'users/:id/relationships' => 'relationships#destroy', as: 'user_relationship'

  get 'items/:id/likes' => 'likes#create', as: 'item_like'
  delete 'items/:id/likes' => 'likes#destroy', as: 'item_likes'

  # get 'items/:id' => 'items#new'
  # post '/items/new', as: 'new_item'
  # get 'items' => 'items#show'
  # post '/items/show', as: 'item'
  #=> 'items#show'
  # post '/items/:id/replies' => 'reply#create', as: 'item_comments'
  #
  resources :users do
    resources :relationships, only: %i[create destroy]
  end

  resources :items do
    resources :orders, only: %i[index create]
    resources :likes, only: %i[create destroy]
    resources :comments do
      resources :replies, only: [:create]
    end
  end
end
