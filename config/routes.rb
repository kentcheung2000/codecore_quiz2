Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy]
  
  
  resources :ideas do
    resources :reviews, shallow: true, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy]
    end

  end

  root 'ideas#index'


end
