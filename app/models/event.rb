class Event < ApplicationRecord
  belongs_to :admin, class_name: "User" # indique que Event appartient à un admin, qui est en fait de la classe User
  has_many :attendances
  has_many :customers, class_name: "User", through: :attendances # indique que Event a plusieurs customers, qui sont en fait de la classe User

  validates :title, presence: true, length: { in: 3..140, message: ": Le nombre de caractère doit être compris entre 5 et 140" }
  validates :description, presence: true, length: { in: 20..1000, message: ": Le nombre de caractère doit être compris entre 20 et 1000" }
  validates :start_date, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000, only_integer: true }
  validates :location, presence: true
  
  validate :start_date_must_be_from_today
  validate :duration_must_be_a_positive_multiple_of_5

  def end_date
    start_date + duration.minutes
  end

  def period
    start_date..end_date
  end

  private # pour éviter qu'une méthode soit appelée en dehors de la classe (car elle n'est utile qu'au sein meme de cette classe) >>> https://www.rubyguides.com/2018/10/method-visibility/

  def start_date_must_be_from_today
    errors.add(:start_date, "Impossible de créer ou modifier un événement dans le passé.") unless start_date > DateTime.now
  end

  def duration_must_be_a_positive_multiple_of_5
    errors.add(:duration, "La durée doit être un nombre positif multiple de 5 !") if ( duration.negative? || !(duration % 5).zero? || duration.zero? ) # ou duration == nil || duration % 5 == 0 || start_date == nil
  end

end
