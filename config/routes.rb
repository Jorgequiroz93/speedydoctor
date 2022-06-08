Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  get '/doctors', to: 'users#doctors'
end
