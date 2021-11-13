class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?, only: [:index]
  before_action :find_event
  before_action :stripe_amount, only: [:new, :create]

  def index
  end

  def new # formulaire doit être branché à Stripe et doit faire payer à l'utilisateur le prix de l'événement.
  end

  def create # Sans la présence de begin et end, rails considère le début du rescue à la ligne def create et son end au prochain end (ici, celui de la méthode create).
    # Before the rescue, at the beginning of the method
    begin
      # Création de plusieurs paramètres dont l’email et le stripeToken. Le stripeToken concerne les informations liées à la carte bleue et permet de les garder en mémoire.
      customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
      })
      # Si le paiement fonctionne, création d'un charge
      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @stripe_amount,
      description: "Inscription à un évènement",
      currency: 'eur',
      })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path(@event)
    end
    # After the rescue, if the payment succeeded
    # Par exemple : enregistrer cette commande en base de données (ou vider un panier...)
    Attendance.create(stripe_customer_id: customer.id, customer: current_user, event: @event) if charge.paid
    redirect_to root_path 
    flash[:success] = "Votre inscription est bien enregistrée, un email de confirmation a été envoyé."

    # Doc Stripe API pour jouer sur les objets Stripe (ex : customer, charge, etc): 
    # https://stripe.com/docs/api/charges/object?lang=ruby
    # https://stackoverflow.com/questions/26985956/checking-for-a-successful-charge-using-stripe-for-rails

  end 

end
