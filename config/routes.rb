Rails.application.routes.draw do

  resources :users do 
    get :pending, on: :collection
    get :search , on: :collection
  end  

  put 'reset_password',to: 'sessions#reset_password'
  post 'signin',to: 'sessions#login'


  resources :devices  do
    get :unassigned, on: :collection
    get :assigned ,  on: :collection
    get :search   ,  on: :collection
  end
  
end
