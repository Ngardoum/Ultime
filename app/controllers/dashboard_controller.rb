class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.restaurant?
      restaurant_dashboard
    elsif current_user.client?
      render 'client_dashboard'
    else
      flash[:alert] = "Accès non autorisé."
      redirect_to root_path
    end
  end

  # Tableau de bord pour les restaurants
  def restaurant_dashboard
    @restaurant = current_user.restaurants.first
    @restaurants = current_user.restaurants

    if @restaurant.nil?
      flash[:alert] = "Vous devez créer un restaurant avant de pouvoir gérer des menus."
      redirect_to new_restaurant_path
    else
      @menus = @restaurant.menus # Récupère tous les menus du restaurant
      render 'restaurant_dashboard'
    end
  end

  # Tableau de bord pour les clients
  def client_dashboard
    @orders = current_user.orders.includes(:menu) # Inclut les menus liés aux commandes du client
    render 'client_dashboard'# Logique pour le tableau de bord client
  end
end
