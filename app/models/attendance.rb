class Attendance < ApplicationRecord
  after_create :send_attendance

  belongs_to :customer, class_name: "User" # indique que Attendance appartient à un customer, qui est en fait de la classe User
  belongs_to :event

  private

  def send_attendance
    UserMailer.attendance_email(self).deliver_now
  end
  
end
