Rails.application.routes.draw do
  resources :entries, only: %i{create edit index new show update}
  resources :songs, only: %i{create edit index new show update}
  resources :weeks, only: %i{index}
  resources :years, only: %i{index}
  resources :artists, only: %i{create edit index new show update}
  root 'application#index'
end
