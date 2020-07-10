Rails.application.routes.draw do
  resources :entries, only: %i{create new}
  resources :songs, only: %i{create edit index new show update}
  resources :artists, only: %i{create edit index new show update}

  # Entries
  get '/entries', to: 'years#index', as: 'years'
  get '/entries/:year/', to: 'weeks#index', as: 'weeks'
  get '/entries/:year/:week', to: 'entries#index', as: 'entries_index'
  get '/entries/:year/:week/edit', to: 'entries#edit', as: 'edit_entries'
  put '/entries/:year/:week', to: 'entries#update', as: 'update_entries'

  root 'application#index'
end
