class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?, only: [:index, :edit, :update]

  def index
    @event = Event.find(params[:id])
    @attendances = Attendance.find_by(@event).customers
  end

  def new # formulaire doit être branché à Stripe et doit faire payer à l'utilisateur le prix de l'événement.
    @user = User.find(params[:id])
  end

  def create # Attention, il faut bien faire en sorte que si la carte bleue ne passe pas ou si le paiement échoue, on ne va pas créer en base une participation.
    params_attendance = params[:attendance]
    @attendance = Attendance.new(
      first_name: params_attendance[:first_name],
      last_name: params_attendance[:last_name]
    )
    if @attendance.save
      @attendance.customer = current_user # créer la participation associée à l'événement et l'utilisateur
      @attendance.stripe_customer_id.save # stocker la stripe_id de l'utilisateur qui resservira pour une opération future 
      flash[:success] = "Votre participation est bien enrigistrée. Un email de confirmation vous a été envoyé." 
      redirect_to root_path
    else
      flash[:warning] = @attendance.errors.full_messages
      render :new
    end
  
  end

  def edit
  end

  def update
  end
end
