Rssreader::Application.routes.draw do

  devise_for :users

  resources :feeds
  post '/feeds', to: 'feeds#create', as: 'create_feed'

  resources :posts
  resources :users
  resources :feed_users

  get '/my_profile', to: 'users#my_profile', as: :my_profile

  root to: "home#home"

end
