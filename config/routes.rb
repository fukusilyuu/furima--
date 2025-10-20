Rails.application.routes.draw do
  devise_for :users

  root 'items#index'
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'users/:user_id/relationships' => 'relationships#create', as: 'relationships'
  delete 'users/:user_id/relationships' => 'relationships#destroy', as: 'relationship'

  get 'items/:item_id/likes' => 'likes#create', as: 'item_likes'
  delete 'items/:item_id/likes' => 'likes#destroy', as: 'item_like'

  # get 'comments/:id' => 'comments#create'
  # post '/comments/new', as: 'new_item'
  # get 'items' => 'items#show'
  # post '/items/show', as: 'item'
  #=> 'items#show'
  # post '/items/:item_id/comments/:comment_id/replies' => 'comments#create'
  # post '/items/comments/:item_id/replies' => 'replies#create', as: 'item_comments'

  resources :users, only: [] do
    resources :relationships, only: %i[create destroy]
  end

  resources :relationships, only: %i[create destroy]

  resources :items do
    resources :orders, only: %i[index create]
    resources :likes, only: %i[create destroy]
    resources :comments do
      resources :replies, only: [:create]
    end
  end
end
