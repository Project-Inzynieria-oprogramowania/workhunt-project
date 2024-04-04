Rails.application.routes.draw do
  root :to => "home#index"

  # Регистрация
  get '/registration', to: 'home#registration'
  get '/registration/user', to: 'users#new'
  get '/registration/organization', to: 'organizations#new'
  # Вход в аккаунт
  get '/login', to: 'home#login'
  get '/login/user', to: 'users#login'
  get '/login/organization', to: 'organizations#login'
  
  #get '/users/:id', to: 'users#show'#, as: 'user'
  # resources :user, only: [:show]
end
