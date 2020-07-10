Rails.application.routes.draw do
  resources :artists
  root 'application#index'
end
