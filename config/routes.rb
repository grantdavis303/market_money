Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "up" => "rails/health#show", as: :rails_health_check

  get "/api/v0/markets/search", to: "api/v0/market_search#index"
  get "/api/v0/markets/:id/nearest_atms", to: "api/v0/nearest_atms#index"

  namespace :api do
    namespace :v0 do
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index], controller: :market_vendors
      end

      resources :market_vendors, only: [:create]
      delete "market_vendors", to: "market_vendors#destroy"

      resources :vendors, only: [:show, :create, :update, :destroy]
    end
  end
end