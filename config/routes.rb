Rails.application.routes.draw do
  root to: 'topics#index'
  resources :topics, only: [:show], param: :name
end
