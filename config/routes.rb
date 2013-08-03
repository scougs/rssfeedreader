Rssreader::Application.routes.draw do

  resources :feeds
  post '/feeds', to: 'feeds#create', as: 'create_feed'


  resources :posts
  resources :users

  devise_for :users

  get '/my_profile', to: 'users#my_profile', as: :my_profile
  get "home/index"
 
  root to: "home#home"

end
