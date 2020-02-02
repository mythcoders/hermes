# frozen_string_literal: true

require 'sidekiq-ent/web'

Rails.application.routes.draw do
  namespace :api do
    post 'messages', to: 'messages#new'
    post 'notifications', to: 'notifications#new'
  end

  devise_for :users
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :clients
  resources :messages, param: :tracking_id do
    get 'reroute', action: :reroute, on: :member
  end

  root to: 'home#index', as: 'home'
end
