Rails.application.routes.draw do
  root :to => "home#index"

  # Registration
  get '/registration', to: 'users#new'
  post '/users', to: 'users#create'

  # Log In - Out
  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # Update User information
  get '/user/settings', to: 'users#edit'
  patch '/user/update', to: 'users#update'

  # Vacancies Bissness Cards
  get '/vacancy/new', to: 'vacancies#new'
  post '/vacancy/create', to: 'vacancies#create'
  get '/vacancies', to: 'vacancies#index'
  get '/vacancy/:id', to:'vacancies#show', as: 'vacancy'
  
  # get '/user/:id', to: 'users#show'#, as: 'user'
end