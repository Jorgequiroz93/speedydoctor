Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  get '/dashboard' to: 'pages#dashboard'
  get '/ourservices' to: 'pages#ourservices'

end
