Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root 'items#index'
  resources :comments
  resources :reports, only: [:new,:create]
  resources :replies, only: [:create]
  resources :items do
    resources :comments do
      resources :replies, only: [:create] do 
    resources :orders, only: [:index, :create] 
    collection do
      get 'search'
       end
      end
    end
  end
end
