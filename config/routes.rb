Rails.application.routes.draw do
  root :to => "home#index"

  # Registration
  get '/registration', to: 'users#new'
  post '/users', to: 'users#create'

  # Log In - Out
  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # User information
  get '/user/settings', to: 'users#edit'
  patch '/user/update', to: 'users#update'
  delete '/user/destroy', to: 'users#destroy'
  get '/user/:id', to: 'users#show', as: 'user'

  post '/user/settings/emails/create', to: 'emails#create', as: 'email_create'
  delete '/user/settings/emails/:id/destroy', to: 'emails#destroy', as: 'email_destroy'
  post '/user/settings/links/create', to: 'links#create', as: 'link_create'
  delete '/user/settings/links/:id/destroy', to: 'links#destroy', as: 'link_destroy'
  post '/user/settings/telephones/create', to: 'telephones#create', as: 'telephone_create'
  delete '/user/settings/telephones/:id/destroy', to: 'telephones#destroy', as: 'telephone_destroy'

  # Vacancies Bissness Cards
  get '/vacancies/new', to: 'vacancies#new'
  post '/vacancies/create', to: 'vacancies#create'
  get '/vacancies', to: 'vacancies#index'
  get '/vacancies/:id', to: 'vacancies#show', as: 'vacancy'
  get '/vacancies/:id/edit', to: 'vacancies#edit', as: 'vacancy_edit'
  patch '/vacancies/:id/update', to: 'vacancies#update', as: 'vacancy_update'
  delete '/vacancies/:id/destroy', to: 'vacancies#destroy', as: 'vacancy_destroy'
  
end