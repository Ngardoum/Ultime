class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :all_restaurants]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  
  def index
    @restaurants = current_user.restaurants
  end
  
  def show
    @restaurant = Restaurant.find(params[:id])
  end

  
  def new
    @restaurant = current_user.restaurants.build
  end
  
  def all_restaurants
    @restaurants = Restaurant.all
    render 'all_restaurants' # Assurez-vous que cette vue existe
  end

  def create
    @restaurant = current_user.restaurants.build(restaurant_params)
    if @restaurant.save
        redirect_to @restaurant, notice: 'Restaurant créé avec succès.'
    else
        render :new
    end
  end
  
  def edit
    @restaurant = Restaurant.find(params[:id])
  end
  
  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant mis à jour avec succès.'
    else
      render :edit
    end
  end
  
  
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path, notice: 'Le restaurant a été supprimé avec succès.'
  end
  
  
  private
  
  def set_restaurant
  end
  
  def restaurant_params
    params.require(:restaurant).permit(:logo, :slogan, :name, :address, :cuisine_type, :country, :latitude, :longitude)
  end
end
