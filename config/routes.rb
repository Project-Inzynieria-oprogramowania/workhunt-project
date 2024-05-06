Rails.application.routes.draw do
  root :to => "home#index"

  resource :user, except: [:index, :destroy, :show] do    
    resources :emails, only: [:create, :destroy]
    resources :telephones, only: [:create, :destroy]
    resources :links, only: [:create, :destroy]
  end
  resources :users, except: [:index, :create, :new, :edit, :show, :update, :destroy] do
    member do
      get '/', to: 'users#show', as: 'show'
    end
  end

  resource :sessions, only: [:new, :create, :destroy]
  
  resource :cv, except: [:index] do
    resource :education, only: [:new, :destroy]
    resource :experience, only: [:new, :destroy]
    resource :language, only: [:new, :destroy]
  end
  resources :cvs, except: [:create, :new, :edit, :show, :update, :destroy] do
    collection do
      post '/search', to: 'cvs#search', as: 'search'
    end

    member do
      get '/', to: 'cvs#show', as: 'show', defaults: { format: :html }
      get '/pdf', to: 'cvs#show', defaults: { format: :pdf }
    end
  end

  resources :vacancies do
    collection do
      post '/search', to: 'vacancies#search', as: 'search'
    end
  end
  
  get '*unmatched_route', to: 'home#routing_error'
end