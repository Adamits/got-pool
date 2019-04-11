Rails.application.routes.draw do
  root to: "home#index"

  resources :updates, only: [:index]
end
