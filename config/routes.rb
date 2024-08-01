Rails.application.routes.draw do
  devise_for :users
  root to: "landing_page#home"

  resources :messages
  resources :leases
  resources :payments
  resources :units
  resources :properties do
    get "units", on: :member, to: "properties#units"
  end

  get "dashboard", to: "dashboard#index", as: "dashboard_index"
  get "tenant/:id", to: "dashboard#tenant", as: "tenant"
end
