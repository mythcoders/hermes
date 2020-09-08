# frozen_string_literal: true

require 'sidekiq-ent/web'

Rails.application.routes.draw do
  namespace :api do
    post 'messages', to: 'messages#new'
    post 'notifications', to: 'notifications#new'
  end

  root to: 'home#index', as: 'home'

  devise_for :users
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'

    resources :clients do
      resources :client_environments, path: :environments, as: :environments
    end
    resources :mailing_topics
    resources :messages, param: :tracking_id
    resources :subscribers
    resources :subscriptions
    resources :templates
  end
end
