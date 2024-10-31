class MenusController < ApplicationController
   before_action :set_restaurant, except: [:all_menus, :index]
   before_action :set_menu, only: [:show, :edit, :update, :destroy]
  
   def index
     @restaurant = Restaurant.find(params[:restaurant_id])
     @menus = @restaurant.menus
   end

   def all_menus
     @menus = Menu.includes(:restaurant) # Charge tous les menus avec leur restaurant associé
   end
  
   def show
     @menu = @restaurant.menus.find(params[:id])
   end  
   
   def new
    @restaurant = Restaurant.find(params[:restaurant_id]) # ou un autre moyen d'identifier le restaurant
    @menu = @restaurant.menus.build
   end

   def create
     if current_user.restaurant?
       @menu = @restaurant.menus.build(menu_params)
       if @menu.save
         redirect_to restaurant_menus_path(@restaurant), notice: 'Menu créé avec succès.'
       else
         render :new
       end
     else
       redirect_to root_path, alert: "Vous n'êtes pas autorisé à créer des menus."
     end
   end
  
  
   def edit
     @menu = @restaurant.menus.find(params[:id])
   end
  
   def update
     @menu = @restaurant.menus.find(params[:id])
     if @menu.update(menu_params)
       redirect_to restaurant_menu_path(@restaurant, @menu), notice: 'Menu mis à jour avec succès.'
     else
      render :edit
     end
   end

   def destroy
     @menu = @restaurant.menus.find(params[:id])
     @menu.destroy
     redirect_to restaurant_menus_path(@restaurant), notice: 'Menu supprimé avec succès.'
   end
  
   private

   def set_restaurant
     @restaurant = Restaurant.find(params[:restaurant_id])
   end

   def set_menu
     @menu = @restaurant.menus.find(params[:id])
   end

   def menu_params
     params.require(:menu).permit(:name, :description, :price, :image)
   end
end
