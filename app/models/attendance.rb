class Attendance < ApplicationRecord
  after_create :send_new_order_to_admin
  after_create :send_order_validation_to_customer

  belongs_to :customer, class_name: "User" # indique que Attendance appartient à un customer, qui est en fait de la classe User
  belongs_to :event

  private

  def send_new_order_to_admin
    UserMailer.new_order_email(self).deliver_now
  end

  def send_order_validation_to_customer
    event = self.event
    customer = self.customer # pb ?????
    UserMailer.order_validation_email(customer, event).deliver_now
  end
  
end
