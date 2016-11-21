# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

15.times do
  # first_name = Faker::Name.first_name
  # last_name = Faker::Name.last_name
  email = Faker::Internet.email
  user = User.new(
    email: email,
    password: "aaaaaaaa",
    # phone: Faker::PhoneNumber.cell_phone,
    # first_name: first_name,
    # last_name: last_name,
    )
  user.save
end

game1 = Game.create!(user: User.first, name: "toto", description: "caca boudin", address: "rue trevise", phone_number: "01 01 01 01 01", min_players: 2, max_players: 5, price_per_hour: 45)
game2 = Game.create!(user: User.last, name: "tata", description: "coco boudin", address: "rue richer", phone_number: "01 01 01 01 01", min_players: 2, max_players: 5, price_per_hour: 45)
