Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home', to: 'pages#home'
  #get 'recipes', to: 'recipes#index'
  #get 'recipes/new', to: 'recipes#new', as: 'new_recipe'
  #get 'recipes/:id', to: 'recipes#show'
  
  resources :recipes do
    resources :comments, only: [:create, :destroy]
  end
  
  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]
  resources :ingredients, except: [:destroy]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get 'pages/top', to: 'pages#top'
  get 'pages/middle', to: 'pages#middle'
  get 'pages/bottom', to: 'pages#bottom'
  
  mount ActionCable.server => '/cable'
  get '/chat', to: 'chatrooms#show'
  
  resources :messages, only: [:create]
  
end
