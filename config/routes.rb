Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  get '/styleguide', to: 'pages#styleguide'

  get '/doctors', to: 'users#doctors'

  get '/dashboard', to: 'pages#dashboard'

  # get '/ourservices' to: 'pages#ourservices'
  # get '/becomespeedy' to: 'pages#becomespeedy'

  resources :consultations, only: [:show]
end
