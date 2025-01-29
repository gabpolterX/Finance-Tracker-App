Rails.application.routes.draw do
  resources :user_stocks
  devise_for :users
    
  root 'welcome#index'
  resources :stocks, only: [:show, :index]

end
