Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  root  'sessions#new'
  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
end
