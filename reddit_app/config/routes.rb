# == Route Map
#
#       Prefix Verb   URI Pattern                Controller#Action
#        users GET    /users(.:format)           users#index
#              POST   /users(.:format)           users#create
#     new_user GET    /users/new(.:format)       users#new
#    edit_user GET    /users/:id/edit(.:format)  users#edit
#         user GET    /users/:id(.:format)       users#show
#              PATCH  /users/:id(.:format)       users#update
#              PUT    /users/:id(.:format)       users#update
#              DELETE /users/:id(.:format)       users#destroy
#  new_session GET    /session/new(.:format)     sessions#new
# edit_session GET    /session/edit(.:format)    sessions#edit
#      session GET    /session(.:format)         sessions#show
#              PATCH  /session(.:format)         sessions#update
#              PUT    /session(.:format)         sessions#update
#              DELETE /session(.:format)         sessions#destroy
#              POST   /session(.:format)         sessions#create
#                                    

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users 

  resource :session 
end
