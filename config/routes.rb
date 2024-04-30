Rails.application.routes.draw do
  root :to => "home#index"

  resource :user, except: [:index, :destroy, :show] do    
    resources :emails, only: [:create, :destroy]
    resources :telephones, only: [:create, :destroy]
    resources :links, only: [:create, :destroy]
  end
  resources :users, except: [:index, :create, :new, :edit, :show, :update, :destroy] do
    collection do
      get '/:id', to: 'users#show', as: 'show'
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
      get '/:id', to: 'cvs#show', as: 'show'
    end
  end

  resources :vacancies
  
  get '*unmatched_route', to: 'home#routing_error'
end