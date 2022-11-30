Rails.application.routes.draw do
  resources :roles
  resources :users 
  post 'accept_pending_request',to: 'users#accept_pending_request'
  get 'pending_users',to: 'users#pending_users'
  post 'users/signup',to: 'users#create'
  post 'users/signin',to: 'sessions#login'
  put 'reset_password',to: 'sessions#reset_password'
  delete 'signout',to: 'sessions#logout'
 end
