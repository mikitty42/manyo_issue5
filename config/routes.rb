Rails.application.routes.draw do
    resources :sessions, only: [:new,:create,:destroy]
    root to: 'tasks#index'
  resources :tasks do
      collection do
          post :confirm
    end
  end
  namespace :admin do
  resources :users
  end
end
