Rails.application.routes.draw do
  devise_for :users
  root to: "dashboard#index"

  resources :messages
  resources :leases
  resources :payments
  resources :units
  resources :properties do
    get "units", on: :member, to: "properties#units"
  end

  get "tenant/:id", to: "dashboard#tenant", as: "tenant"
end
