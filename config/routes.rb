Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", :as => :rails_health_check
  mount MissionControl::Jobs::Engine, at: "/jobs"

  resources :senders
  resources :bans
end
