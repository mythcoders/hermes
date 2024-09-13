Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", :as => :rails_health_check

  # namespace :api do
  #   post "messages", to: "messages#new"
  #   post "notifications", to: "notifications#new"
  # end

  mount MissionControl::Jobs::Engine, at: "/jobs"

  resources :bans
  resources :senders do
    resources :profiles
    resources :messages
  end
end
