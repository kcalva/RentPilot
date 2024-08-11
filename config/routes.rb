Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: "landing_page#home"

  resources :properties, except: [:show] do
    resources :units, except: [:show]
    # get "units", on: :member, to: "properties#units"
  end

  resources :tenant, only: [:show] do
    resources :leases, only: [:index]
    resources :payments, only: [:index]
  end

  # resources :messages
  # resources :leases
  # resources :units
end
