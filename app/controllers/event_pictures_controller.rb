class EventPicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_event_admin?

  def create
    @event = Event.find(params[:event_id]) # identifier l'event concerné
    unless params[:event_picture]
      @event.errors.add(:event_picture, 'Fichier non reconnu')
      flash.now[:warning] = "Fichier non reconnu"
      render :create
      return
    end
    @event.event_picture.attach(params[:event_picture]) # attriber le fichier dont la référence est contenue dans params[:nom_du_fichier]
    flash[:success] = "L'image a bien été ajoutée."
    redirect_to(event_path(@event)) # redirection vers la page show du event
  end

  private

  # restreindre l'accès
  def is_event_admin?
    @event = Event.find(params[:event_id])
    unless current_user == @event.admin
      flash.now[:danger] = "Vous n'êtes pas autorisé(e) à accéder à cette page"
      redirect_to root_path
    end
  end

end
