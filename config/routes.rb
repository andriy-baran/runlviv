Rails.application.routes.draw do
  get 'terms-of-service', to: 'pages#terms_of_service'

  get 'privacy-policy', to: 'pages#privacy_policy'

  get 'contact', to: 'pages#contact'

  resources :runs
  root to: 'visitors#index'
  devise_for :users
end
