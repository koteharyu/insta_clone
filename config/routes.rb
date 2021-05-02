# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        users#new
#                     users GET    /users(.:format)                                                                         users#index
#                           POST   /users(.:format)                                                                         users#create
#                  new_user GET    /users/new(.:format)                                                                     users#new
#                 edit_user GET    /users/:id/edit(.:format)                                                                users#edit
#                      user GET    /users/:id(.:format)                                                                     users#show
#                           PATCH  /users/:id(.:format)                                                                     users#update
#                           PUT    /users/:id(.:format)                                                                     users#update
#                           DELETE /users/:id(.:format)                                                                     users#destroy
#                     posts GET    /posts(.:format)                                                                         posts#index
#                           POST   /posts(.:format)                                                                         posts#create
#                  new_post GET    /posts/new(.:format)                                                                     posts#new
#                 edit_post GET    /posts/:id/edit(.:format)                                                                posts#edit
#                      post GET    /posts/:id(.:format)                                                                     posts#show
#                           PATCH  /posts/:id(.:format)                                                                     posts#update
#                           PUT    /posts/:id(.:format)                                                                     posts#update
#                           DELETE /posts/:id(.:format)                                                                     posts#destroy
#                     login GET    /login(.:format)                                                                         sessions#new
#                           POST   /login(.:format)                                                                         sessions#create
#                    logout DELETE /logout(.:format)                                                                        sessions#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  root 'users#new'
  resources :relationships, only: [:create, :destroy]
  resources :users
  resources :posts, shallow: true do
    resources :comments
    resources :likes, only: [:create, :destroy]
    collection do
      get :like_posts
    end
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
