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

    resources :clients, except: %i[delete] do
      get 'messages', to: 'clients#messages', as: 'messages'
      get 'subscribers', to: 'clients#subscribers', as: 'subscribers'
      match 'send_email', to: 'clients#send_email', as: 'send_email', via: %i[get post]
      resources :client_environments, path: :permissions, as: :environments, except: %i[delete]
      resources :client_uploads, path: :uploads, as: :uploads, except: %i[delete]
      resources :mailing_topics, path: :topics, as: :topics, except: %i[delete]
      resources :subscribers, except: %i[delete]
      resources :templates, except: %i[delete]
    end
    resources :messages, param: :tracking_id, only: %i[index show]
    resources :subscriptions, only: %i[index edit update]
  end
end
