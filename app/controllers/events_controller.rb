class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.all #transmettre les données de la table events à la view (sous forme d'array de hashs)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
  end
  
  def create
    params_event = params[:event]
    @event = Event.new(
      title: params_event[:title],
      description: params_event[:description],
      location: params_event[:location],
      start_date: params_event[:start_date],
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

end
