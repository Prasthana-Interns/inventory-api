Rails.application.routes.draw do
  resources :users 
  get 'pending_users',to: 'users#pending_users'
  post 'jwt/decode',to: 'application#authorized_user'
  post 'users/signup',to: 'users#create'
  post 'users/signin',to: 'sessions#login'
  delete 'users/signout',to: 'sessions#logout'
end
