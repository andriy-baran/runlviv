Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :runs
    resources :support_messages
    resources :group_runs
    resources :strava_imports
    resources :competitions
    resources :challenges

    root to: "users#index"
  end

  devise_scope :user do
    get '/auth/strava/callback', to: 'sessions#strava', as: :strava_integration
  end
  # get '/auth/strava', to: 'sessions#create', as: :strava

  get 'terms-of-service', to: 'pages#terms_of_service'
  get 'privacy-policy', to: 'pages#privacy_policy'
  get 'contact', to: 'pages#contact'
  post 'contact', to: 'pages#contact', as: :send_support_message

  resources :challenges, only: :index
  resources :competitions, only: [:index, :show]
  resources :runs do
    get :import_strava, on: :collection
    get :sync_strava, on: :member
  end
  resources :group_runs do
    post :add_user, on: :member
  end
  root to: 'visitors#index'
  devise_for :users, controllers: { omniauth_callbacks: 'sessions' }

  resources :users, only: [] do
    get :profile, to: 'pages#profile', on: :member
    get :runs, to: 'runs#my_runs', on: :member
  end
end
