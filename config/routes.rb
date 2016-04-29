Rails.application.routes.draw do

  root 'page#index'

  #Sessions
  get 'login' => 'sessions#login'
  post 'login/auth'=> 'sessions#authorize_user'
  get 'logout'=> 'sessions#logout'
  
  #User
  get 'me/:id/info' => "users#profile", as: :me_info
  get 'me/:id/edit' => 'users#edit_profile', as: :me_edit
  get 'me/:id' => 'users#dashboard', as: :me
  
  get 'signup', to: "users#new_profile"
  
  post 'users/create_profile' => 'users#create_profile'
  patch 'users/update_profile' => 'users#update_profile'
  delete 'users/destroy_profile' => 'users#destroy_profile'
  patch 'users/block_profile' => 'users#block_profile'
  patch 'users/follow_profile' => 'users#follow_profile'
  patch 'users/suscribe_event' => 'users#suscribe_event'

  get 'me/:id/events' => 'events#index', as: :event
  get 'me/:id/events/new_event' => 'events#new_event', as: :event_new  
  get 'me/:id/events/:event_id' => 'events#info_event', as: :event_info
  get 'me/:id/events/:event_id/edit' => 'events#edit_event', as: :event_edit
  post 'event/create_event' => 'events#create_event', as: :event_create  
  patch 'event/update_event' => 'events#update_event', as: :event_update
  delete 'event/:event_id/delete_event' => 'events#delete_event', as: :event_delete

  get '/photos' => 'photos#index'
  post 'event/:id/add_photos' => 'photos#create', as: :photo_create
  delete 'me/:id/events/:event_id/:image_id/delete_photo' => 'photos#delete', as: :photo_delete

  match '404' => 'page#not_found', via: [:get]
end
