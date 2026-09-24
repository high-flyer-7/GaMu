Rails.application.routes.draw do
  get "top/index"

  get "up" => "rails/health#show", as: :rails_health_check


  root 'top#index'
end
