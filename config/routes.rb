Rails.application.routes.draw do

  resources :libraries
  devise_for :normals, :admins, :users



  # devise_for :users
  class ApiConstraints
    def initialize(options)
      @version = options[:version]
      @default = options[:default]
      
    end

    def matches?(req)
      @default
    end
  end

      


  namespace :api do
    namespace :v2, format: :json, constraints: ApiConstraints.new(version: 2, default: true) do
        devise_for :users, :controllers => { registrations: 'api/v2/registrations' }
        devise_scope :user do
          post 'sign_up', to: 'registrations'
          post 'sign_in', to: 'registrations', defaults: {format: :json}
        end
      post 'libraries/purchase'
      resources :libraries

    end
  end

  namespace :api do
    namespace :v1, format: :json, constraints: ApiConstraints.new(version: 1, default: true) do

      devise_for :users, :controllers => { registrations: 'api/v1/registrations' }
     

      devise_scope :user do
        post 'sign_up', to: 'registrations', defaults: {format: :json}
        post 'sign_in', to: 'registrations', defaults: {format: :json}
      end
      post 'libraries/purchase'
      resources :libraries
    end
  end  
end
