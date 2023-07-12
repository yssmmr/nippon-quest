Rails.application.routes.draw do


  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  get 'posts/favorite' => 'posts#favorite'
  get 'posts/top' => 'posts#top'

  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end

  get 'users/search'

  resources :users, only: [:show, :edit, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' =>'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  get '/about' => 'homes#about'

  resources :notifications, only: [:index]
  delete 'notifications/destroy_all' => 'notifications#destroy_all'

  root to: 'homes#about'
end
