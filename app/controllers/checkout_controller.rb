class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, only: [:create]
  #before_action :stripe_amount, only: [:create]
  
  def create
    @price = params[:price].to_d
    customer = Stripe::Customer.create
    @session = Stripe::Checkout::Session.create(
      customer: customer.id,
      payment_method_types: ['card'],
      line_items: [
        {
          name: 'Rails Stripe Checkout',
          amount: (@price*100).to_i,
          currency: 'eur',
          quantity: 1
        },
      ],
      metadata: [@event.id.to_s],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    respond_to do |format|
      format.js # renders create.js.erb
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    puts "#" * 60
    puts @session
    puts "#" * 60
    puts "#" * 60
    puts @event
    puts "#" * 60
    puts "#" * 60
    puts @session.metadata
    puts "#" * 60
    Attendance.create(stripe_customer_id: @session.customer, customer: current_user, event: Event.find(@session.metadata["0"].to_i)) if @session.payment_status = "paid"
    # todo : réussir à trouver la bonne synthaxe metadata pour faire passer "event" à la place "0" ce serait plus propre)
  end

  def cancel
  end

end

# https://stripe.com/docs/testing
