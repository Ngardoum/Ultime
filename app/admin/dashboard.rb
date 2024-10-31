ActiveAdmin.register_page "Dashboard" do
  content do
    # Section principale du tableau de bord
    panel "Gestion des données principales" do
      div do
        # Bouton pour afficher la liste des utilisateurs
        span link_to("Voir les Utilisateurs", admin_users_path, class: "button primary")

        # Bouton pour afficher la liste des restaurants
        span link_to("Voir les Restaurants", admin_restaurants_path, class: "button primary")

        # Bouton pour afficher la liste des menus
        span link_to("Voir les Menus", admin_menus_path, class: "button primary")
      end
    end

    # Section des statistiques de l'application
    panel "Statistiques de l'application" do
      div class: "statistic-panel" do
        div { "Total des utilisateurs : #{User.count}" }
        div { "Total des restaurants : #{Restaurant.count}" }
        div { "Total des menus : #{Menu.count}" }
      end
    end
  end
end
