Rails.application.routes.draw do
  root :to => "home#index"

  get '/registration', to: 'users#new'
  post '/users', to: 'users#create'
  # get '/login', to: 'users#login'

  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  #get '/users/:id', to: 'users#show'#, as: 'user'
  # resources :user, only: [:show]
end