Rails.application.routes.draw do

  resources :libraries do
    collection { post :import_csv}
  end
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }


  root to: 'libraries#index'

  # devise_for :users
  class ApiConstraints
    def initialize(options)
      @version = options[:version]
      @default = options[:default]
      
    end

    def matches?(req)
      # binding.pry
      @default || req.headers['Accept'].include?("application/v#{@version}")
    end
  end

      


  namespace :api do
      devise_for :users, :controllers => { registrations: 'api/registrations' }
    scope module: :v2, format: :json, constraints: ApiConstraints.new(version: 2) do
        # devise_for :users, :controllers => { registrations: 'api/registrations' }
        devise_scope :user do
          post 'sign_up', to: 'registrations'
          post 'sign_in', to: 'registrations', defaults: {format: :json}
          post 'logout', to: 'registrations', defaults: {format: :json}
          post 'invite_user', to: 'registrations', defaults: {format: :json}

        end
      post 'libraries/purchase'
      resources :libraries

    end
  # end

  # namespace :api do
    scope module: :v1, format: :json, constraints: ApiConstraints.new(version: 1, default: true) do

      # devise_for :users, :controllers => { registrations: 'api/registrations' }
     

      devise_scope :user do
        post 'sign_up', to: 'registrations', defaults: {format: :json}
        post 'sign_in', to: 'registrations', defaults: {format: :json}
        post 'logout', to: 'registrations', defaults: {format: :json}       


      end
      post 'libraries/purchase'
      resources :libraries
    end
  end  
end
