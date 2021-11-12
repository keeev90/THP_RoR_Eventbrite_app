Rails.application.routes.draw do

  # Specify what Rails should route '/'. The root route only routes GET requests to the action > https://edgeguides.rubyonrails.org/routing.html
  root 'events#index'

  # Routes définies automatiquement par la gem Devise > cf rails routes
  devise_for :users

  # Autres routes dont le controller manipule des données en base ou des données temporaires (via méthodes CRUD)
  resources :users, only: [:show, :edit, :update] do
    resources :profile_pictures, only: [:create] # imbriquer la route dans le resources :users pour lui rajouter un /users/user_id/ en amont du path.
  end
  resources :events do 
    resources :attendances, only: [:index, :new, :create]
    resources :event_pictures, only: [:create] # imbriquer la route dans le resources :events pour lui rajouter un /events/event_id/ en amont du path.
  end

  # Controller Namespaces and Routing >>> https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing
  namespace :admin do
    root 'welcome#index'
    resources :users
    resources :events
    resources :event_validations, only: [:index, :show, :edit, :update]
  end
  
end

# NB : Rails routes are matched in the order they are specified > https://edgeguides.rubyonrails.org/routing.html
