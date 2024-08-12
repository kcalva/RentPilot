Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: "landing_page#home"

  resources :properties, except: [:show] do
    resources :units, except: [:show]
  end

  resources :tenant, only: [:show] do
    resources :leases, only: [:index]
    resources :payments, only: [:index]
  end

  # resources :messages
end
