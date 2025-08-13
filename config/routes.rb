Rails.application.routes.draw do
  devise_for :users

    resources :wazas, only: [:index, :show]
    resources :videos, only: %i[index show]
    resources :ranks,  only: %i[index show]

  namespace :admin do
    resources :members
    resources :ranks
    resources :wazas
    root "dashboard#index"
  end

  namespace :mypage do
    root to: "dashboard#index"
  end

  root "home#index"
end
