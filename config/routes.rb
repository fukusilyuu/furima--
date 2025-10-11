Rails.application.routes.draw do
  devise_for :users

  root 'items#index'
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'items/:id/relationships' => 'relationships#create'
  get 'items/:id/likes' => 'likes#create'

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
