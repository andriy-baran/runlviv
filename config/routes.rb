Rails.application.routes.draw do
  get 'terms-of-service', to: 'pages#terms_of_service'
  get 'privacy-policy', to: 'pages#privacy_policy'
  get 'contact', to: 'pages#contact'
  get 'profile', to: 'pages#profile'

  resources :runs
  root to: 'visitors#index'
  devise_for :users, controllers: { omniauth_callbacks: 'sessions' }
end
