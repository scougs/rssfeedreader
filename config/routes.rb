Rssreader::Application.routes.draw do

  devise_for :users

  resources :feeds
  post '/feeds', to: 'feeds#create', as: 'create_feed'
<<<<<<< HEAD
  get '/feeds', to: 'feeds#index', format: 'json'
=======
>>>>>>> 0251ffe034bf43e741a54bd5d10a313b8f58015c

  resources :posts
  resources :users
  resources :feed_users

<<<<<<< HEAD
  # delete '/feedusers/:id', to: 'feedusers#destroy', as: 'delete_feeduser'

  get '/my_profile', to: 'users#my_profile', as: :my_profile
  get "home/index"
=======
  get '/my_profile', to: 'users#my_profile', as: :my_profile
 
>>>>>>> 0251ffe034bf43e741a54bd5d10a313b8f58015c
  root to: "home#home"

end
