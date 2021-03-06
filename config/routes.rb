Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  resources :doctors, only: [:show] do
    resources :consultations, only: [:create]
  end

  resources :consultations, only: [:show, :update] do
    resources :reviews, only: [:create, :update]
    resources :reports, only: [:create]
  end
  resources :reports, only: [:show]

  # resources :reports, only: [:show]
  # resources :doctors, only: [:show]
  post '/consultations/:id', to: 'reviews#create'

  get '/styleguide', to: 'pages#styleguide'

  get '/doctors', to: 'users#doctors'
  get '/dashboard', to: 'pages#dashboard'

  # get '/ourservices' to: 'pages#ourservices'
  get '/becomespeedy', to: 'pages#becomespeedy'

  patch '/dashboard/available', to: 'doctors#change_status_to_available'
  patch '/dashboard/off', to: 'doctors#change_status_to_off'

  # get '/ourservices' to: 'pages#ourservices'
  # get '/becomespeedy' to: 'pages#becomespeedy'

  resources :users, only: [:index] do
    member do
      post 'toggle_favorite', to: "users#toggle_favorite"
    end
  end
end
