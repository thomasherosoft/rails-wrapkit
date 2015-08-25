Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }, skip: [:registrations]

  root 'home#index'

  get '/customers/import', to: 'customers#import', as: 'import_customers'
  resources :customers do
    member do
      get 'overview'
      get 'verification'
      get 'service'
      get 'billing'
      get 'history'
    end
  end

  resources :marketing do
    collection do
      get 'products'
      get 'programs'
      get 'digital_field'
      get 'collateral'
      get 'promotions'
    end
  end

  resources :independent_contractors do
    member do
      get 'overview'
      get 'information'
      get 'stats'
      get 'payroll'
      get 'ongoing_deals'
      post 'badged_image_upload'
    end
    collection do
      get 'add'
    end
  end

  namespace :api do
    scope defaults: { format: 'json' } do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:registrations]

      api_version(module: 'V1', path: {value: 'v1'}) do
        get '/auth_test', to: 'base#auth_test'
      end
    end
  end
end
