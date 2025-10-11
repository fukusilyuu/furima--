Rails.application.routes.draw do
  devise_for :users

  root 'items#index'
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'items/:id/relationships' => 'relationships#create', as: 'item_relationships'
  delete 'items/:id/relationships' => 'relationships#destroy', as: 'item_relationship'

  get 'items/:id/likes' => 'likes#create', as: 'item_like'
  delete 'items/:id/likes' => 'likes#destroy', as: 'item_likes'

  get 'items/:id' => 'items#show', as: 'items'

  resources :comments
  resources :reports, only: %i[new create]
  resources :replies, only: [:create]

  resources :items do
    resource :relationships, only: %i[create destroy]
    resources :orders, only: %i[index create]
    resources :likes, only: %i[create destroy]
    resources :comments do
      resources :replies, only: [:create]
    end
  end
end
