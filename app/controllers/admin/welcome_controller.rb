class Admin::WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :is_website_admin?

  # Page d'accueil de ton dash admin, et elle souhaitera la bienvenue à ton administrateur et permettra de naviguer dans les différentes views admins
  def index 
  end

  # Les controllers administrateurs ne devront être accessibles qu'aux administrateurs de ton application.
  def is_website_admin? 
    unless current_user.is_website_admin
      redirect_to root_path, danger: "Accès refusé. Vous n'êtes pas administrateur de ce site."
    end
  end
end

################ TO DO ###################
### DANS L'INTERFACE ADMIN ###
# Les views avec les paths admin
# Les méthodes EDIT et UPDATE du controller event_validations pour valider (ou pas) l'événement
# vérifier si Admin:: devant chaque controller admin est une bonne synthaxe 
# savoir comment s'attribuer un rôle admin ???

### DANS L'INTERFACE NORMALE ###
# La création d'un événement va changer > validated nil par défaut. A passer en false si l'événement est refusé, et à true s'il est accepté
# L'index des événements va changer > @events ira prendre que les événements qui sont validés
# Impossible de faire #show sur un événement en cours de validation