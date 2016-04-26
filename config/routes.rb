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

  match '404' => 'page#not_found', via: [:get]
end
