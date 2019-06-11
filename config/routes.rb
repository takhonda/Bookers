Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post '/rate' => 'rater#create', :as => 'rate'
  root 'books#home'
  # get 'users/index'

  devise_for :users
  get 'books/:id' => 'books#show', as: 'book'

  # root :to => 'books#index'
  
  get '/about' => 'books#about',as: 'about'
  
  get '/home' => 'books#home',as: 'home'
  
  get '/books' => 'books#index',as: 'index'
  
  get '/search' => 'books#search',as: 'books_search'
  
  
  delete '/books/:id' => 'books#destroy', as: 'destroy_books'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books
  resources :books, only: [:new, :create, :index, :show] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
end
  resources :users
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
