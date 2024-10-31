class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :payment, :charge]
  before_action :set_restaurant, only: [:new, :create, :create_and_pay]

  def index
    @orders = current_user.orders # Récupère toutes les commandes de l'utilisateur connecté
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.find(params[:menu_id])
    @order = Order.new
    @order.order_items.build # Cela crée un nouvel item de commande
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def payment
    # Logique pour afficher la page de paiement, pas de traitement ici
  end

  def charge
    token = params[:stripeToken]
  
    if @order.user == current_user
      begin
        # Traitement du paiement via Stripe
        charge = Stripe::Charge.create({
          amount: (@order.total_price * 100).to_i, # montant en centimes
          currency: 'eur',
          source: token,
          description: "Paiement pour la commande ##{@order.id}"
        })
  
        # Mettre à jour le statut de la commande sur 'paid' en cas de succès
        @order.update(status: 'paid')
  
        # Rediriger avec un message de succès
        flash[:notice] = "Votre paiement a été effectué avec succès. La commande est maintenant validée."
        redirect_to @order
      rescue Stripe::CardError => e
        # Rediriger avec un message d'erreur en cas d'échec
        flash[:alert] = "Échec du paiement : #{e.message}"
        redirect_to payment_order_path(@order) # Assurez-vous que cela redirige correctement
      end
    else
      flash[:alert] = "Vous n'êtes pas autorisé à payer cette commande."
      redirect_to root_path
    end
  end
  
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @order = current_user.orders.build(
      restaurant: @restaurant,
      status: "pending"
    )
  
    # Construire manuellement les order_items depuis les params
    if params[:order_items_attributes]
      params[:order_items_attributes].each do |item|
        @order.order_items.build(
          menu_id: item[:menu_id],
          quantity: item[:quantity]
        )
      end
    end
  
    calculate_total_price
  
    if @order.save
      redirect_to order_path(@order), notice: 'Commande créée avec succès.'
    else
      render :new
    end
  end
  
  def create_and_pay
    @restaurant = Restaurant.find(params[:restaurant_id])
    menu = Menu.find(params[:menu_id])
    
    # Création d'une commande avec un seul item basé sur le menu sélectionné
    @order = current_user.orders.build(
      restaurant: @restaurant,
      status: "pending"
    )
    
    # Ajoute un seul item dans la commande avec une quantité de 1 (ou personnalisable)
    @order.order_items.build(menu: menu, quantity: 1)
    calculate_total_price

    if @order.save
      redirect_to payment_order_path(@order), notice: 'Commande créée avec succès. Veuillez procéder au paiement.'
    else
      flash[:alert] = "Erreur lors de la création de la commande."
      redirect_to all_menus_path
    end
  end
  
  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def order_params
    @order = Order.new(params[:command])
  end
  
  def set_order
    @order = Order.find(params[:id])
  end

  def calculate_total_price
    @order.total_price = @order.order_items.sum { |item| item.menu.price * item.quantity }
  end
end
