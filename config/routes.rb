Rails.application.routes.draw do
  
  # Page d'accueil
  root to: 'home#index'
  resources :posts, only: [:index, :show, :new, :create]

  # ActionCable pour le chat en temps réel
  mount ActionCable.server => '/cable'

  # Authentification Devise pour les utilisateurs et les admin_users
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Redirection vers le tableau de bord après authentification
  authenticated :user do
    get 'dashboard', to: 'dashboard#show', as: :user_dashboard
  end

  # Tableau de bord principal
  get 'dashboard', to: 'dashboard#show', as: :dashboard

  # Pages d'affichage de tous les restaurants et tous les menus
  get 'all_restaurants', to: 'restaurants#all_restaurants', as: 'all_restaurants'
  get 'all_menus', to: 'menus#all_menus', as: 'all_menus'

  # Ressources pour les utilisateurs, les restaurants, les menus, et les commandes
  resources :users, only: [:index]

  resources :restaurants do
    resources :menus, only: [:new, :create, :index, :edit, :update, :destroy] do
      resources :orders, only: [:new, :create]  # Commandes associées à un menu spécifique d'un restaurant
    end  
  end

  resources :menus, only: [] do
    resources :orders, only: [:show, :index] do

    end  # Commandes pour un menu sans restaurant
  end

  resources :orders, only: [:show, :index] do
    member do
      get 'payment'   # Affiche le formulaire de paiement
      post 'charge'   # Traite le paiement
    end
    collection do
      post 'create_and_pay' # Route pour créer et payer depuis all_menus
    end
  end  

  # Routes pour la messagerie et les conversations
  resources :conversations, only: [:index, :new, :create, :show] do
    resources :messages, only: [:create]
  end
end
