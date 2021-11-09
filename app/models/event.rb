class Event < ApplicationRecord
  belongs_to :admin, class_name: "User" # indique que Event appartient à un admin, qui est en fait de la classe User
  has_many :attendances
  has_many :customers, class_name: "User", through: :attendances # indique que Event a plusieurs customers, qui sont en fait de la classe User

  validates :title, presence: true, length: { in: 3..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :start_date, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { only_integer: true }, inclusion: {in: 1..1000}
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
    errors.add(:start_date, "Impossible de créer ou modifier un événement dans le passé.") if start_date < Time.now
  end

  def duration_must_be_a_positive_multiple_of_5
    errors.add(:duration, "La durée doit être un nombre positif multiple de 5 !") if ( duration.negative? || !(duration % 5).zero? || duration.zero? )
  end

end
