Rails.application.routes.draw do
  # For Action Cable working
  # mount ActionCable.server => '/cable'
  
  root :to => "home#index"
  
  resources :notifications, only: [] do
    collection do
      patch :marks_as_read
    end
  end
  resource :user, except: [:index, :destroy, :show] do    
    resources :emails, only: [:create, :destroy]
    resources :telephones, only: [:create, :destroy]
    resources :links, only: [:create, :destroy]
    resources :responses, only: [:index]
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
    resources :responses, only: [:index, :create]
  end

  resources :responses, except: [:index, :new, :edit]

  get '*unmatched_route', to: 'home#routing_error'
end