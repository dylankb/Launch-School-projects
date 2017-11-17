PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get '/logout', to: 'session#destroy'

  resources :users, only: [:show, :create, :edit, :update]
  resources :sessions

  resources :posts, except: :destroy do
    resources :comments, only: :create
    resources :categories, only: :create
  end
  resources :categories, only: [:new, :show]
end
