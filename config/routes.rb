Rails.application.routes.draw do
  devise_for :users

  root 'items#index'
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'users/:user_id/relationships' => 'relationships#create', as: 'relationships'
  delete 'users/:user_id/relationships' => 'relationships#destroy', as: 'relationship'

  get 'items/:item_id/likes' => 'likes#create', as: 'item_likes'
  delete 'items/:item_id/likes' => 'likes#destroy', as: 'item_like'

  # get 'items/:item_id/comments/:comment_id/likes' => 'likes#create', as: 'item_comments_likes'
  # delete 'items/:item_id/likes' => 'likes#destroy', as: 'item_like'
  #
  # get 'items/item_id/comments/comment_id/replies/:id' => 'replies#edit'
  # post 'items/item_id/comments/comment_id/replies/:id/edit' => 'replies#update'

  resources :users do
    resources :relationships, only: %i[create destroy]
  end

  resources :relationships, only: %i[create destroy]

  resources :items do
    resources :orders, only: %i[index create show]
    resources :likes, only: %i[create destroy]
    resources :comments do
      resources :replies
      # resources :likes, only: %i[create destroy]
    end
  end
end
