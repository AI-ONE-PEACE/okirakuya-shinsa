Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :members, only: [:index, :new, :create]

  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      root "dashboard#index"
    end
  end
end
