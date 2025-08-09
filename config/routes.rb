Rails.application.routes.draw do
  get 'members/index'
  get 'members/new'
  get 'members/create'
  namespace :admin do
    root 'dashboard/index'
  end
  devise_for :users
  root 'home#index'
  get 'home/index'

  resources :members, only: [:index, :new, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
