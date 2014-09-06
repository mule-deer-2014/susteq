Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  #EMPLOYEE ROUTES
  namespace :employee do
    resources :sessions, only: [:new, :create, :destroy]
  end
  delete '/employee/signout', to: 'employee/sessions#destroy'

  root :to => "employee/sessions#new"
  resources :providers do
    resources :hubs
  end

  #ADMIN ROUTES
  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy]
  end
  get '/admin', to: "admin/sessions#new"
  delete '/admin/signout', to: 'admin/sessions#destroy'

  namespace :admin do
    resources :kiosks
    resources :pumps
    resources :hubs
    resources :providers do
      resources :hubs
    end
  end

end
