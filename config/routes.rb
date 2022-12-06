Rails.application.routes.draw do

  resources :roles
  resources :users do 
    get :pending_users, on: :collection
    post :accept_pending_request,on: :member
    get :search , on: :collection
  end  

  put 'reset_password',to: 'sessions#reset_password'
  post 'users/signup',to: 'users#create'
  post 'users/signin',to: 'sessions#login'


  resources :devices  do
    get :unassigned, on: :collection
    get :assigned ,  on: :collection
    get :search   ,  on: :collection
  end
end
