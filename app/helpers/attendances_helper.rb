module AttendancesHelper
  def stripe_amount
    @amount = @event.price
    @stripe_amount = (@amount * 100).to_i # définition du montant à facturer en centimes (!)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end
