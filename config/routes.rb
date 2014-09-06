Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  #EMPLOYEE ROUTES
  root :to => "employee/sessions#new"
  delete '/employee/signout', to: 'employee/sessions#destroy'

  namespace :employee do
    resources :sessions, only: [:new, :create, :destroy]
  end

  resources :providers, only: [:show, :edit, :update] do
    resources :hubs, only: [:index, :show]
    resources :employees
  end

  #ADMIN ROUTES
  get '/admin', to: "admin/sessions#new"
  delete '/admin/signout', to: 'admin/sessions#destroy'

  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy]
  end

  namespace :admin do
    resources :kiosks
    resources :pumps
    resources :hubs
    resources :providers do
      resources :hubs, :employees
    end
  end

end
