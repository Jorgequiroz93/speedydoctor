Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users 

  resources :users, only: [] do 
    resources :consultations, only: [:create]
  end

  get '/styleguide', to: 'pages#styleguide'
  
  get '/doctors', to: 'users#doctors'
  get '/dashboard', to: 'pages#dashboard'
  get '/doctors/doctors[:id]', to: 'users#doctors'
  

 # get '/ourservices' to: 'pages#ourservices'
 # get '/becomespeedy' to: 'pages#becomespeedy'
  
  resources :consultations, only: [:show] do
    resources :reviews, only: [:create, :update]
    resources :reports, only: [:create]
  end

  resources :reports, only: [:show]
  resources :doctors, only: [:show]


end
