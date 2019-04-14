Rails.application.routes.draw do
  root to: "home#index"

  resources :comments, only: [:create]
  resources :users, only: [:show]
end
