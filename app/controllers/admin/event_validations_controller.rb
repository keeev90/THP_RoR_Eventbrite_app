class Admin::EventValidationsController < Admin::WelcomeController
  before_action :is_website_admin?
  before_action :events_to_validate
  before_action :event_to_submit

  def index #  recense tous les événements à valider
  end

  def show # affiche un événement à valider précis
  end

  def edit
  end

  def update # valider (ou pas l'événement)
  end

  private

  def events_to_validate
    @events_to_validate = []
    Events.all.each do |event|
      unless event.validated
        @events_to_validate << event
      end 
    end
  end

  def event_to_validate
    @event_to_validate = Event.find(params[:id])
  end

  def is_website_admin?
    unless current_user.is_website_admin
      redirect_to root_path, danger: "Accès refusé. Vous n'êtes pas administrateur de ce site."
    end
  end

end