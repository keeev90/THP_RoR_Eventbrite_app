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
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.admin = current_user
    if @event.save 
      flash[:success] = "L'évènement a bien été créé." 
      redirect_to root_path
    else
      flash.now[:warning] = @event.errors.full_messages
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = "Votre évènement a été édité avec succès !"
      redirect_to @event
    else
      flash.now[:warning] = @event.errors.full_messages
      render :edit
    end
  end

  def destroy # ajouter remboursement et emailing en cas d'inscriptations déjà enregistrées
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "L'évènement a bien été supprimé."
      redirect_to root_path
    else 
      flash.now[:warning] = "Erreur : l'évènement n'a pas été supprimé"
      redirect_to @event
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :start_date, :duration, :price)
  end

end
