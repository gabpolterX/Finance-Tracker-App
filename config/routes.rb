Rails.application.routes.draw do
  devise_for :users
    
  root 'welcome#index'
  resources :stocks, only: [:index]
  resources :user_stocks, only: [:create, :destroy]
end
