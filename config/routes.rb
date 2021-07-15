Rails.application.routes.draw do
  
  devise_for :users
  resources :follows, only: [:create, :destroy]
  #resources :likes, only: [:create]

  root to: "home#index"

  resources :users, only: [:show, :index, :edit, :update] do
    resources :posts do
      resources :comments
      resources :likes, only: [:create, :destroy]
    end
    resources :followers, only: :index
    resources :followings, only: :index
  end
end