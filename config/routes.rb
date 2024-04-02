Rails.application.routes.draw do
  root :to => "home#index"

  # Регистрация
  get '/users/registration', to: 'users#registration'
  get '/users/registration/user', to: 'users#registrationuser'
  get '/users/registration/organization', to: 'users#registrationorganization'
  # Вход в аккаунт
  get '/users/login', to: 'users#login'
  get '/users/login/user', to: 'users#loginuser'
  get '/users/login/organization', to: 'users#loginorganization'
  
  #get '/users/:id', to: 'users#show'#, as: 'user'
  # resources :user
end
