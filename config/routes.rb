Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: "landing_page#home"

  resources :properties, except: [:show] do
    resources :units, except: [:show]
  end

  resources :users, only: [:show] do
    resources :leases, except: [:show]
    resources :payments, except: [:show]
  end

  # resources :messages
end
