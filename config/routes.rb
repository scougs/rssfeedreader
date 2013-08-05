Rssreader::Application.routes.draw do
  devise_for :users
  resources :feeds
  post '/feeds', to: 'feeds#create', as: 'create_feed'
  get '/feeds', to: 'feeds#index', format: 'json'

  resources :posts
  resources :users
  resources :feed_users

  # delete '/feedusers/:id', to: 'feedusers#destroy', as: 'delete_feeduser'

  get '/my_profile', to: 'users#my_profile', as: :my_profile
  get "home/index"
  root to: "home#home"

end
