Rails.application.routes.draw do
  root to: 'home#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup',to: 'users#new'
  resources :users, except: [:index]
  resources :decks do
   resources :favorites, only: [:index, :create, :destroy]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end