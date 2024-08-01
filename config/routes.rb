Rails.application.routes.draw do
  devise_for :users
  root to: "dashboard#index"

  resources :messages
  resources :leases
  resources :payments do
    collection do
      get "tenant/:tenant_id", to: "payments#index", as: "tenant"
    end
  end
  resources :units
  resources :properties do
    get "units", on: :member, to: "properties#units"
  end

  get "tenant/:id", to: "dashboard#tenant", as: "tenant"
end
