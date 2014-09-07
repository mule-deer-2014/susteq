Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root :to => "sessions#new"

  #EMPLOYEE ROUTES
  get '/employee/signout', to: 'employee/sessions#destroy', as: 'employee_signout' #get rather than delete bc of issue with twitter bootstrap link_to
  get '/providers/:provider_id/dashboard', to:"providers#dashboard", as: "provider_dashboard"

  namespace :employee do
    resources :sessions, only: [:new, :create, :destroy]
  end

  resources :providers, only: [:show, :edit, :update] do
    resources :employees
    resources :pumps
    resources :kiosks
  end


  #ADMIN ROUTES
  get '/admin', to: "admin/sessions#new"
  get '/admin/signout', to: 'admin/sessions#destroy', as: 'admin_signout' #get rather than delete bc of issue with twitter bootstrap link_to
  get '/admin/dashboard', to:"admin/admins#dashboard", as: "admin_dashboard"

  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy]
    get '/dashboard', to: "admin/dashboard#index"
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
