Rails.application.routes.draw do
  devise_for :users

  # 管理画面
  namespace :admin do
    resources :members
    resources :ranks, only: [:index]
    resources :wazas
    root "dashboard#index"
  end

  resources :wazas, only: [:index, :show]# 一般画面
  root "home#index"
end
