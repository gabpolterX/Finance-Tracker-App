Rails.application.routes.draw do
  devise_for :users
    
  root 'welcome#index'
  resources :stocks, only: [:show, :index]

end
