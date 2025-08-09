Rails.application.routes.draw do
  devise_for :users

  # 管理画面
  namespace :admin do
    resources :members
    root "dashboard#index"
  end

  root "home#index"
end
