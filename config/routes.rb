Rails.application.routes.draw do
  root to: "home#top"
  
  get "signup",to: "users#new"
  post "login",to: "users#login"
  post "logout",to: "users#logout"
  get "login",to: "users#login_form"
  resources :users, only: [:show, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end