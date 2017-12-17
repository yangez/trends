Rails.application.routes.draw do
  resources :topics, only: [:show]
end
