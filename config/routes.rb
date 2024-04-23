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
    member do
      get 'education/add', to: 'cvs#add_education', as: 'add_education'
      delete 'education/remove', to: 'cvs#remove_education', as: 'remove_education'
      get 'experience/add', to: 'cvs#add_experience', as: 'add_experience'
      delete 'experience/remove', to: 'cvs#remove_experience', as: 'remove_experience'
      get 'language/add', to: 'cvs#add_language', as: 'add_language'
      delete 'language/remove', to: 'cvs#remove_language', as: 'remove_language'
    end
  end
  resources :cvs, except: [:index, :create, :new, :edit, :show, :update, :destroy] do
    collection do
      get '/:id', to: 'cvs#show', as: 'show'
    end
  end

  resources :vacancies
  
  get '*unmatched_route', to: 'home#routing_error'
end