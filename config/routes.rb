Rails.application.routes.draw do
  resources :songs
  resources :artists, only: %i{create edit index new show update}
  root 'application#index'
end
