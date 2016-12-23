Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  get 'welcome/about'
  
  root 'welcome#index', via: :get



  resources :users , except: [:index] do
    resources :requests, only: [:index,:update,:create,:destroy]
    resources :friends, only: [:index,:delete]
    resource :bio , except: [:index]
    resources :search, only: [:index]
    resource :profile_picture, only: [:new,:create,:destroy]
    resources :activity_feeds, only: [:index]
    resource :security_level, only: [:update]

    resources :photos do 
      resources :comments,only: [:create,:destroy] do 
        resources :likes,only: [:create,:destroy]
      end
      resources :likes,only: [:create,:destroy]
    end

    resources :posts do 
      resources :comments,only: [:create,:destroy] do 
        resources :likes,only: [:create,:destroy]
      end
      resources :likes,only: [:create,:destroy]
    end

    resources :albums do 
      resources :comments,only: [:create,:destroy] do
        resources :likes,only: [:create,:destroy]
      end
      resources :likes, only: [:create,:destroy]
      resources :photos do 
        resources :likes, only: [:create,:destroy]
      end
    end
  end  
end
