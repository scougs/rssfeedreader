Rssreader::Application.routes.draw do
  devise_for :users
  root to: "home#home"
  resources :feeds
  resources :posts
  resources :users
end
