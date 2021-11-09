Rails.application.routes.draw do

  # Specify what Rails should route '/'. The root route only routes GET requests to the action > https://edgeguides.rubyonrails.org/routing.html
  root 'events#index'

  # Routes définies automatiquement par la gem Devise > cf rails routes
  devise_for :users

  # Autres routes dont le controller manipule des données en base ou des données temporaires (via méthodes CRUD)
  resources :users, only: [:show, :edit, :update]
  resources :events
  
end

# NB : Rails routes are matched in the order they are specified > https://edgeguides.rubyonrails.org/routing.html
