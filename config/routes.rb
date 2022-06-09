Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  resources :doctors, only: [] do 
    resources :consultations, only: [:create]
  end

  resources :consultations, only: [:show] do
    resources :reviews, only: [:create, :update]
    resources :reports, only: [:create]
  end

  resources :reports, only: [:show]
  resources :doctors, only: [:show]


  get '/styleguide', to: 'pages#styleguide'

  get '/doctors', to: 'users#doctors'
  get '/dashboard', to: 'pages#dashboard'


 # get '/ourservices' to: 'pages#ourservices'
  get '/becomespeedy', to: 'pages#becomespeedy'

  # get '/ourservices' to: 'pages#ourservices'
  # get '/becomespeedy' to: 'pages#becomespeedy'

  resources :consultations, only: [:show]
end
