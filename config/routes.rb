Rssreader::Application.routes.draw do

  devise_for :users

  resources :feeds
  post '/feeds', to: 'feeds#create', as: 'create_feed'

  resources :posts

  resources :entries, only: [:show]

  resources :users, only: [:edit, :update, :show, :index]
  resources :feed_users do
    member do
      put :update_category
    end
  end
  resources :entry_users


  get '/my_profile', to: 'users#my_profile', as: :my_profile


  root to: "home#home"

end
