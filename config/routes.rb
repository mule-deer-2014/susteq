Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root :to => "sessions#new"

  #ROUTES FOR AJAX REQUESTS
  get "/transactions/credits_sold_by_kiosk", to: "transactions#credits_sold_by_kiosk"

  #ROUTES FOR PROVIDER DASHBOARD
  get '/dashboard', to:"dashboard#main", as: "provider_dashboard"
  get '/sessions', to: "sessions#index"
  get '/my_profile', to: 'employees#show_current', as: 'employee_current'
  get '/edit_profile', to: 'employees#edit_current', as: 'employee_edit_current'
  patch '/my_profile', to: 'employees#update_current', as: 'employee_update_current'
  resources :employees
  resources :pumps, only: [:index, :show]
  resources :kiosks, only: [:index, :show]
  namespace :employee do
    get '', to: "sessions#new", as: 'signin'
    get '/signout', to: 'sessions#destroy', as: 'signout' #get rather than delete bc of issue with twitter bootstrap link_to
    resources :sessions, only: [:new, :create, :destroy]
  end

  #ROUTES FOR ADMIN DASHBOARD
  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy]
    get '/', to: "sessions#new", as: 'signin'
    get '/signout', to: 'sessions#destroy', as: 'signout' #get rather than delete bc of issue with twitter bootstrap link_to
    get '/dashboard', to:'dashboard#main', as: 'dashboard'
    get '/operations', to:'dashboard#operations', as: 'operations'
    get '/my_profile', to: 'admins#show_current', as: 'current'
    get '/edit_profile', to: 'admins#edit_current', as: 'edit_current'
    patch '/my_profile', to: 'admins#update_current', as: 'update_current'
    resources :kiosks
    resources :pumps
    resources :hubs
    resources :employees
    resources :admins
    resources :providers do
      resources :pumps, :kiosks, :employees
    end
  end

end
