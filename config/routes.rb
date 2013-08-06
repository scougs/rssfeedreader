Rssreader::Application.routes.draw do

  devise_for :users

  resources :feeds
  post '/feeds', to: 'feeds#create', as: 'create_feed'

  resources :posts


  resources :users, only: [:edit, :update, :show]
  resources :feed_users do
    member do
      put :update_category
    end
  end
  resources :entry_users


  get '/my_profile', to: 'users#my_profile', as: :my_profile

devise_scope :user do
  root to: "devise/sessions#new"
end

end
