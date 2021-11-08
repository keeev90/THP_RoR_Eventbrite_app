# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Faker::Config.locale = 'fr'

User.destroy_all
Event.destroy_all
Attendance.destroy_all

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{first_name.downcase}-#{last_name.downcase}@yopmail.com"

  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    description: Faker::Superhero.descriptor
    )
end

5.times do
  Event.create!(
    title: Faker::DcComics.title,
    description: Faker::Lorem.paragraphs,
    start_date: Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 30),
    duration: 5 * rand(1..60),
    location: Faker::Address.city,
    price: rand(1..1000),
    admin: User.all.sample
    )
end

50.times do
  user_random1 = User.all.sample
  user_random2 = User.all.sample
  
  while user_random1 == user_random2
    user_random2 = User.all.sample #re-tirage aléatoire tant que les users sont identiques (pour éviter qu'un admin soit également un customer d'un même event)
  end

  Attendance.create!(
    stripe_customer_id: Faker::Invoice.reference,
    event: Event.all.sample,
    customer: User.all.sample
    )
end
