Rails.application.routes.draw do
  get "tags/show"
  root "posts#index"

  resources :posts

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/tags/:name", to: "tags#show", as: :tag
end