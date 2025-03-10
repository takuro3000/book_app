Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }

  namespace :admin do
    resources :books, only: %i[index show new create edit update destroy] do
      collection do
        get 'search'
      end
    end
  end

  scope module: :user do
    resources :books, only: %i[index show] do
      resources :posts, only: %i[new create edit update] do
        resources :likes, only: %i[create destroy]
      end
    end
  end
  resources :users, only: %i[show edit update]
  root "pages#home"
  get "about" , to: "pages#about"
  get "privacy_policy", to: "pages#privacy_policy"
  get "terms" , to: "pages#terms"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  # root "posts#index"
end
