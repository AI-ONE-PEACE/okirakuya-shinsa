Rails.application.routes.draw do
  devise_for :users

    resources :wazas, only: [:index, :show]# 一般画面

  # 管理画面
  namespace :admin do
    resources :members
    resources :ranks, only: [:index]
    resources :wazas
    root "dashboard#index"
  end

  root "home#index"
end
