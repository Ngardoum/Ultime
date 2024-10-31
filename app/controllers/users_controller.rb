class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin! # Si seulement les admins peuvent accéder à cette liste (facultatif)

  # Liste les utilisateurs en fonction de leur rôle
  def index
    @clients = User.where(role: 'client')
    @restaurants = User.where(role: 'restaurant')
  end
  
  private

  def ensure_admin!
    unless current_user.admin?
      flash[:alert] = "Vous n'avez pas l'autorisation d'accéder à cette page."
      redirect_to root_path
    end
  end
 
end
