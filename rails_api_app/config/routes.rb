Rails.application.routes.draw do
  namespace :api do
    resources :moons
    resources :planets
    resources :stars
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"
    get "world", to: "world#show"
    get "logger_example", to: "world#logger_example"
    get "external_service", to: "world#external_service"

  end
end
