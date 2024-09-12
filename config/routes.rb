Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  root "public#index"

  mount MissionControl::Jobs::Engine, at: "/jobs"
end
