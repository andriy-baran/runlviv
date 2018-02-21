Rails.application.routes.draw do
  get 'terms-of-service', to: 'pages#terms_of_service'
  get 'privacy-policy', to: 'pages#privacy_policy'
  get 'contact', to: 'pages#contact'

  resources :runs
  root to: 'visitors#index'
  devise_for :users, controllers: { omniauth_callbacks: 'sessions' }

  resources :users, only: [] do
    get :profile, to: 'pages#profile', on: :member
    get :runs, to: 'runs#my_runs', on: :member
  end
end
