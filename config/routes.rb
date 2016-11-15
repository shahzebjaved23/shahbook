Rails.application.routes.draw do
#   get 'user_profile/:id/index/' => "user_profile#index", as: :user_profile_index
#   get 'user_profile/:id/posts' => "user_profile#posts", as: :user_profile_posts
#   get 'user_profile/:id/posts/:post_id' => "user_profile#post", as: :user_profile_post
#   get 'user_profile/:id/photos' => "user_profile#photos", as: :user_profile_photos
#   get 'user_profile/:id/photos/:photo_id' => "user_profile#photo", as: :user_profile_photo
#   get 'user_profile/:id/albums' => "user_profile#albums", as: :user_profile_albums
#   get 'user_profile/:id/albums/:album_id' => "user_profile#album", as: :user_profile_album
#   get 'user_profile/friends'

   

#   get 'book/:name' => 'profile#show_book'
#   get 'movie/:name' => 'profile#movie_book'

#   # Profile Routes------------------------------------------------------------------------
#   get 'profile/index'
#   get 'profile/edit'
#   post 'profile/edit'
#   get 'profile/search' => 'profile#search_friends'
#   get 'users/:id/friends' => 'profile#show_friends', as: :user_friends_path
#   get 'profile/interests' => 'profile#interests'
#   get 'profile/requests' => 'profile#show_friend_requests'
#   post 'profile/send_friend_request' => 'profile#send_friend_request'
#   post 'profile/accept_request' => 'profile#accept_request' 
#   get 'profile/cancel_request'

# # Photo crud routes----------------------------------------------------------------------
#   # Show All
#   get 'profile/show_photos' => 'profile#show_photos' , as: :profile_show_photos
#   # Show One
#   get 'profile/show_photo/:id' => 'profile#show_photo', as: :profile_show_photo
#   # New photo
#   get 'profile/add_photo' => 'profile#add_photo', as: :profile_add_photo
#   # Create Photo
#   post 'profile/add_photo' => 'profile#create_photo'
#   # Edit Photo
#   get 'profile/edit_photo/:id' => 'profile#edit_photo', as: :profile_edit_photo
#   # Update Photo
#   post 'profile/edit_photo/:id' => 'profile#update_photo'
#   # Delete Photo
#   delete 'profile/show_photo/:id' => 'profile#delete_photo' , as: :profile_delete_photo

# # Album crud routes----------------------------------------------------------------------  
#   # Show All
#   get 'profile/show_albums'
#   # Show One
#   get 'profile/show_album/:id' => 'profile#show_album', as: :profile_show_album
#   # Add Album
#   get 'profile/add_album' => 'profile#add_album', as: :profile_add_album
#   # create Album
#   post 'profile/add_album' => 'profile#create_album'
#   # add album photo
#   get 'profile/show_album/:id/add_photo' => 'profile#add_album_photo' , as: :profile_add_album_photo
#   # create album photo
#   post 'profile/show_album/:id/add_photo' => 'profile#create_album_photo'
#   # Edit Album
#   get 'profile/edit_album/:id' => 'profile#edit_album', as: :profile_edit_album
#   # Delete Album
#   delete 'profile/show_album/:id' => 'profile#delete_album', as: :profile_delete_album

# # Comments and replies Crud----------------------------------------------------------------
#   # create Photo Comment and reply
#   get 'profile/show_photo/:id/post_comment' => 'profile#create_photo_comment',as: :profile_photo_comment
#   get 'profile/show_photo/:id/post_comment/:comment_id/post_reply' => 'profile#create_photo_comment_reply',as: :profile_photo_comment_reply
  
#   # create Post Comment and reply
#   get 'profile/show_post/:id/post_comment' => 'profile#create_post_comment', as: :profile_post_comment
#   get 'profile/show_post/:id/post_comment/:comment_id/post_reply' => 'profile#create_post_comment_reply', as: :profile_post_comment_reply
  
#   # create album comment and reply
#   get 'profile/show_album/:id/post_comment' => 'profile#create_album_comment', as: :profile_album_comment
#   get 'profile/show_album/:id/post_comment/:comment_id/post_comment' => 'profile#create_album_comment_reply', as: :profile_album_comment_reply

#   # Delete comment
#   get 'profile/delete_comment/:id' => 'profile#delete_comment' ,as: :profile_delete_comment  

# # Other Profile Routes------------------------------------------------------------------------------
#  post 'profile/change_profile_picture' => 'profile#handle_change_profile_picture_action' , as: :profile_handle_change_profile_picture  
#  post 'profile/change_friend_security_level' => 'profile#change_friend_security_level', as: :profile_change_friend_security_level

# # show profile and root routes  
#   get 'profile/show_profile'

  devise_for :users
  get 'welcome/index'
  get 'welcome/about'
  
  root 'welcome#index'


#   resources :books
#   resources :movies
#   resources :posts
#   resources :bios
#   resources :users
  
  resources :users , except: [:index] do

    resources :requests, only: [:index,:create,:destroy]
    resources :friends, only: [:index]
    resource :bio , except: [:index]
    resources :search, only: [:index]
    resource :profile_picture, only: [:new,:create,:destroy]
    resources :activity_feeds, only: [:index]
    resources :friend_ships, only: [:update,:create,:destroy]
    resource :security_level, only: [:create]

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
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
