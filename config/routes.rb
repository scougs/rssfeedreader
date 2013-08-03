Rssreader::Application.routes.draw do
  get "home/index"
  devise_for :users
  root to: "home#home"
  resources :feeds
  post '/feeds', to: 'feeds#create', as: 'create_feed'


  resources :posts
  resources :users
end
