class EventPicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def create
    @event = Event.find(params[:event_id]) # identifier l'event concerné
    unless params[:event_picture]
      @event.errors.add(:event_picture, 'Image non reconnue')
      render :create, flash: { error: 'Image non reconnue' }
      return
    end
    @event.event_picture.attach(params[:event_picture]) # attriber le fichier dont la référence est contenue dans params[:nom_du_fichier]
    redirect_to(event_path(@event)) # redirection vers la page show du event
    flash[:success] = "L'image a bien été ajoutée."
  end
end
