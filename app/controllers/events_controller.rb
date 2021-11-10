class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :is_admin?, only: [:edit, :update, :destroy]

  def index
    @events = Event.all #transmettre les données de la table events à la view (sous forme d'array de hashs)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @durations_array = []
    50.times do |i|
      @durations_array << (i + 1) * 5
    end
  end
  
  def create
    params_event = params[:event]
    datetime = DateTime.new(
      event['start_date(1i)'].to_i,
      event['start_date(2i)'].to_i,
      event['start_date(3i)'].to_i,
      event['start_date(4i)'].to_i,
      event['start_date(5i)'].to_i,
      event['start_date(6i)'].to_i,
    )

    @event = Event.new(
      title: params_event[:title],
      description: params_event[:description],
      location: params_event[:location],
      start_date: datetime,
      duration: params_event[:duration].to_i,
      price: params_event[:price].to_i,
      admin: current_user
    )
    if @event.save 
      flash[:success] = "L'évènement a bien été créé." 
      redirect_to root_path
    else
      flash[:warning] = @event.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy # ajouter remboursement et emailing en cas d'inscriptations déjà enregistrées
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
    flash[:success] = "L'évènement a bien été supprimé."
  end

end
