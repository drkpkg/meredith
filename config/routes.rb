Rails.application.routes.draw do

  root 'page#index'
  get 'login' => 'sessions#login'
  get 'logout'=> 'sessions#logout'
  get 'signup', to: "users#new_profile"
  get 'me/:id/info' => "users#profile", as: :me_info
  get 'me/:id/edit' => 'users#edit_profile', as: :me_edit
  get 'me/:id' => 'users#dashboard', as: :me
  get 'me/:id/events' => 'events#index', as: :event
  get 'me/:id/events/new_event' => 'events#new_event', as: :event_new
  get 'me/:id/events/:event_id' => 'events#info_event', as: :event_info
  get 'me/:id/events/:event_id/edit' => 'events#edit_event', as: :event_edit
  get '/photos' => 'photos#index'
  post 'login/auth'=> 'sessions#authorize_user'
  post 'users/create_profile' => 'users#create_profile'
  post 'event/create_event' => 'events#create_event', as: :event_create
  post 'event/:id/add_photos' => 'photos#create', as: :photo_create
  patch 'users/update_profile' => 'users#update_profile'
  patch 'users/block_profile' => 'users#block_profile'
  patch 'users/follow_profile' => 'users#follow_profile'
  patch 'users/suscribe_event' => 'users#suscribe_event'
  patch 'event/update_event' => 'events#update_event', as: :event_update
  delete 'event/:event_id/delete_event' => 'events#delete_event', as: :event_delete
  delete 'users/destroy_profile' => 'users#destroy_profile'
  delete 'me/:id/events/:event_id/:image_id/delete_photo' => 'photos#delete', as: :photo_delete
  match '404' => 'page#not_found', via: [:get]

  #API for mobile
  scope 'resources' do
    scope 'spark' do
      scope 'user' do
        post 'auth_user' => 'api#auth_user'
        post 'create_user' => 'api#create_user'
        get 'info_user/:id' => 'api#info_user'
      end
      scope 'event' do
        get 'info_event/:id' => 'api#info_event'
      end

    end
  end

end
