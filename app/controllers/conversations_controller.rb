class ConversationsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      # Afficher toutes les conversations pour l'utilisateur connecté
      @restaurant = User.find(params[:restaurant_id]) # Récupérer le restaurant à partir de l'ID
      @conversation = Conversation.new   
    end
    
    def new
      # Initialiser une nouvelle conversation
      @restaurant = User.find(params[:restaurant_id]) # Assurez-vous que cela renvoie un utilisateur valide
      @conversation = Conversation.new # Récupérer le restaurant à partir de l'ID
    end

    def show
      # Afficher une conversation spécifique
      @conversation = Conversation.find(params[:id])
      @messages = @conversation.messages.order(created_at: :asc)
    end
  
    def create
      if params[:restaurant_id].present?
        @restaurant = User.find(params[:restaurant_id]) # Récupérer le restaurant ici
      else
        redirect_to restaurants_path, alert: 'Restaurant non spécifié.'
        return
      end
    
      @conversation = Conversation.new(conversation_params)
      @conversation.restaurant_id = @restaurant.id
      @conversation.client_id = current_user.id # On suppose que le client est l'utilisateur connecté
    
      if @conversation.save
        redirect_to @conversation
      else
        render :new
      end
    end
    
    
  
    private
  
    def conversation_params
      params.require(:conversation).permit(:restaurant_id, :client_id)
    end
  end