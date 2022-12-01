Rails.application.routes.draw do

  resources :roles
  resources :users do 
    get :pending_users, on: :collection
    post :accept_pending_request,on: :member
  end  
  
  post 'users/signup',to: 'users#create'
  post 'users/signin',to: 'sessions#login'
  
 end
