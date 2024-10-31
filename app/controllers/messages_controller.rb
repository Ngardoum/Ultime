class MessagesController < ApplicationController
  # Vous pouvez désactiver l'authentification pour la création des messages
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @conversation = Conversation.find(params[:conversation_id])
    
    # Ici, vous pouvez créer un message sans que l'utilisateur soit connecté
    @message = @conversation.messages.build(message_params)
    @message.user = User.find_by(username: params[:username]) || User.new(role: 'client', username: params[:username])
    
    if @message.save
      # Broadcasting message via ActionCable
      ActionCable.server.broadcast "chat_channel", message: render_message(@message)
      render json: { success: true }
    else
      render json: { success: false, errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    # Ici, générez le rendu du message à partir du modèle, si nécessaire
    ApplicationController.render(partial: 'messages/message', locals: { message: message })
  end
end
