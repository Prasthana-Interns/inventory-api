Rails.application.routes.draw do
  resources :roles
  resources :users 
  get 'pending_users',to: 'users#pending_users'
  post 'users/signup',to: 'users#create'
  post 'users/signin',to: 'sessions#login'
  delete 'signout',to: 'sessions#logout'
 end
