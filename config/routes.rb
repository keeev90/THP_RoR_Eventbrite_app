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
    resources :attendances, only: [:index]
    resources :event_pictures, only: [:create] # imbriquer la route dans le resources :events pour lui rajouter un /events/event_id/ en amont du path.
  end

  # Admin : Controller Namespaces and Routing >>> https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing
  namespace :admin do
    root 'welcome#index'
    resources :users
    resources :events
    resources :event_validations, only: [:index, :show, :edit, :update]
  end

  # Stripe payment : la notion de `scope`, tout comme celle de `namespace`, peut être vue comme un "pack" de routes qui sera accompagné de son ou ses controllers.
  scope '/checkout' do
    # La ligne `post 'create'` va représenter la demande concrète de création d'une session sécurisée de paiement Stripe. Schématiquement, cette requête `POST` est envoyée à notre serveur, qui "fait suivre" le tout à Stripe via des appels d'API, qui lui-même nous renverra du contenu à l'écran.
    post 'create', to: 'checkout#create', as: 'checkout_create'
    # Le système de Stripe veut que lors d'une session de paiement, on indique 2 URLs de redirection : une URL `success` sur laquelle on atterrit lorsque la session arrive à son terme, et une URL `cancel` lorsque la session est annulée par le client ou que le paiement échoue.
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end
  
end

# NB : Rails routes are matched in the order they are specified > https://edgeguides.rubyonrails.org/routing.html
