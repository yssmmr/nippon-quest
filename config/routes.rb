Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#top'
  get 'posts/favorite'
  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end


  resources :users, only: [:show, :edit, :update, :destroy]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  get '/about' => 'homes#about'


end
