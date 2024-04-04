Rails.application.routes.draw do
  root :to => "home#index"

  # Регистрация
  get '/registration', to: 'home#registration'
  get '/registration/user', to: 'users#new'
  post '/users', to: 'users#create'
  get '/registration/organization', to: 'organizations#new'
  post '/organizations', to: 'organizations#create'
  
  # Вход в аккаунт
  get '/login', to: 'home#login'
  get '/login/user', to: 'users#login'
  get '/login/organization', to: 'organizations#login'
  
  #get '/users/:id', to: 'users#show'#, as: 'user'
  # resources :user, only: [:show]
end
