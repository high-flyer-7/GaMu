Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root 'top#index'

  get "terms", to: "pages#terms"
  get "privacy", to: "pages#privacy"
  get "player", to: "players#show"
end
