Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :providers do
    resources :hubs
  end

  namespace :admin do
    resources :providers, shallow: true do
      resources :hubs
    end
  end
  namespace :admin
    resources :sessions, only: [:new, :create, :destroy]
  end

  namespace :employee
    resources :sessions, only: [:new, :create, :destroy]
  end

  get '/', {:controller => "/employee/sessions", :action => "new"}
  get '/admin', {:controller => "/admin/sessions", :action => "new"}
  delete '/signout', to: 'sessions#destroy'
end
