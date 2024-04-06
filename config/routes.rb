Rails.application.routes.draw do
  root :to => "home#index"

  get '/registration', to: 'users#new'
  post '/users', to: 'users#create'
  get '/login', to: 'users#login'
  
  #get '/users/:id', to: 'users#show'#, as: 'user'
  # resources :user, only: [:show]
end