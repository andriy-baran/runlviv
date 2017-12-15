Rails.application.routes.draw do
  resources :runs
  root to: 'visitors#index'
  devise_for :users
end
