# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index', as: 'home'

  devise_for :users
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :clients
  resources :mail_logs
end
