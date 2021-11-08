class Attendance < ApplicationRecord
  belongs_to :customer, class_name: "User" # indique que Attendance appartient à un customer, qui est en fait de la classe User
  belongs_to :event
end
