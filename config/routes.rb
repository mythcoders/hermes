Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", :as => :rails_health_check
  resource :session
  resources :passwords, param: :token

  namespace :api do
    post "aws/*other", to: "aws#new"
    post "messages", to: "messages#new"
    # post "unsubscribe/:destination_id", to: "subscriptions#unsubscribe", as: "unsubscribe"
  end

  mount MissionControl::Jobs::Engine, at: "/jobs"

  resources :bans
  resources :senders do
    resources :profiles
    resources :messages
  end
end
