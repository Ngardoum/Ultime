class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
    # Permettre des paramètres supplémentaires pour Devise lors de l'inscription et de la mise à jour du compte
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role, :username])
  end
  
    # Rediriger l'utilisateur vers le tableau de bord après connexion
  def after_sign_in_path_for(resource)
    user_dashboard_path
  end
end
