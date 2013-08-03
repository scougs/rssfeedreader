Rssreader::Application.routes.draw do

  resources :feeds
  resources :posts
  resources :users

  devise_for :users

  get '/my_profile', to: 'users#my_profile', as: :my_profile
  get "home/index"
 
  root to: "home#home"

end
