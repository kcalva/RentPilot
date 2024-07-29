Rails.application.routes.draw do
  devise_for :users

  resources :messages
  resources :leases
  resources :payments
  resources :units
  resources :properties

  root to: "home#index"
end
