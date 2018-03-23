Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :runs

    root to: "users#index"
  end

  get '/auth/:provider/callback', to: 'sessions#create', as: :integration

  get 'terms-of-service', to: 'pages#terms_of_service'
  get 'privacy-policy', to: 'pages#privacy_policy'
  get 'contact', to: 'pages#contact'
  post 'contact', to: 'pages#contact', as: :send_support_message

  resources :runs
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
