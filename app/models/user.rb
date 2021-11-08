class User < ApplicationRecord
  has_many :administrated_events, foreign_key: 'admin_id', class_name: "Event", dependent: :destroy # Ces events correspondent à la colonne admin_id de la classe Event >>> permet de faire des méthodes .admin et .administrated_events
  has_many :attendances, foreign_key: 'customer_id', class_name: "Attendance", dependent: :destroy # Ces attendances correspondent à la colonne customer_id de la classe Attendance >>> permet de faire des méthodes .customer et .attendances
  has_many :events, through: :attendances

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Please enter a valid email adress" }  
  
  #has_secure_password #indiquer que bcrypt est en charge de gérer et hasher les mots de passe
  
  #validates :password, presence: true, length: { minimum: 6 }
end
