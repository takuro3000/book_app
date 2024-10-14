Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }

  namespace :admin do
    resources :books, only: %i[index show new create edit update destroy]
  end

  scope module: :user do
    resources :books, only: %i[index show] do
      resources :posts, only: %i[index new create]
    end
    resources :posts, only: %i[index new create] do
      resources :likes, only: %i[create destroy]
    end
  end

  root "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  # root "posts#index"
end
