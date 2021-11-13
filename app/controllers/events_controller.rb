class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_admin?, only: [:edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
  end
  
  def create
    @event = Event.new(event_params)
    @event.admin = current_user
    if @event.save 
      flash[:success] = "L'évènement a bien été créé." 
      redirect_to root_path
    else
      flash[:warning] = @event.errors.full_messages
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, success: "Votre évènement a été édité avec succès !"
    else
      render :edit
    end
  end

  def destroy # ajouter remboursement et emailing en cas d'inscriptations déjà enregistrées
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to root_path
      flash[:success] = "L'évènement a bien été supprimé."
    else 
      redirect_to @event
      flash[:warning] = "Erreur : l'évènement n'a pas été supprimé"
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :start_date, :duration, :price)
  end

end
