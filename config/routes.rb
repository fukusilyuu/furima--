Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  get 'up' => 'rails/health#show', as: :rails_health_check

  # resources :comments
  # resources :reports, only: %i[new create]
  # resources :replies, only: [:create]

  resources :items do
    resources :orders, only: %i[index create]
    resources :comments do
      resources :replies, only: [:create]
    end
  end
end

# resources :reports, only: %i[new create]resources :replies, only: [:create]resources :items do resources :orders, only: %i[index create]
