# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Booking.all.each { |game| game.destroy }
Game.all.each { |game| game.destroy }
User.all.each { |game| game.destroy }



# game1 = Game.create!(user: User.first, name: "Very Bad Night",
# description: "Après un lendemain de soirée difficile, vous vous réveillez dans un appartement inconnu. A en juger par l’état des lieux la soirée semble avoir été bien arrosée, mais hormis un énorme mal de crâne vous ne vous rappelez plus de grand chose. Il va vite falloir vous remettre les idées en place, car le propriétaire arrive bientôt sur les lieux…",
# address: "24 Rue Emile Lepeu, 75011 Paris",
# phone_number: "01 02 03 04 05",
# min_players: 3,
# max_players: 5,
# price_per_hour: 46)


# game2 = Game.create!(user: User.last, name: "La lettre d'André Citroen",
#   description: "Bienvenue dans cette salle d’examen ! C’est dans cette pièce circulaire que l’office notariale, en charge de la succession d’André Citroën, va mettre à l’épreuve votre sagacité. La décoration de la salle reprend les codes des showrooms / concessions de la marque automobile. Vous retrouverez différents objets publicitaires, des enjoliveurs, des revêtements de sièges auto, … bref, une salle en adéquation avec le thème du jeu : Citroën.
# Un des points notables, qui donne de la crédibilité à la situation, est la mise en condition des joueurs. Avant-même de rentrer dans la salle vous serez accueillis par le(s) représentant(s) du notaire. L’un d’entre eux garde près de lui la fameuse mallette à laquelle il est attaché par des menottes, sécurité oblige. C’est une fois les présentations faites que vous serez amenés au dernier étage du C42, via un ascenseur privé, pour démarrer votre partie.
# Ce cérémonial est parfait pour faire entrer les équipes dans le jeu, pour donner l’illusion de se retrouver dans une aventure un peu hors du commun.",
# address: "42 avenue des Champs-Elysées, 75008 PARIS",
# phone_number: "01 01 01 01 01",
# min_players: 2,
# max_players: 5,
# price_per_hour: 45)


# game3 = Game.create!(user: User.last, name: "Le casse du siècle",
#   description: "C’est dans une salle à l’ambiance feutrée, dont la décoration nous fait penser à la salle des trophées d’une université américaine, que débutera votre aventure. Tableaux, objets sous protections, cordons rouges, tous les éléments qui forment l’image d’Epinal du musée à la française ont été intégrés dans le décor de cette aventure.
# Mais au-delà de ça, le décor du Casse du siècle va vous permettre d’en savoir plus sur la fameuse Lock Academy. Alors que les deux précédents jeux Un crime presque parfait et Très Cher Lock mettaient en scène les personnages de cette école de détective, cette fois-ci c’est la Lock Academy elle-même qui est le personnage central de l’intrigue. Un moyen d’en apprendre un peu plus sur cette école, forte d’une histoire prestigieuse qui a pu attirer à elle la crème des détectives du XIXème et du XXème siècle : Kojak, Miss Marple, l’inspecteur Maigret, Mata Hari, … ils ont tous été formés à la Lock Academy et une part d’eux est restée dans les lieux que vous allez découvrir…
# Si vous êtes déjà venus jouer par le passé à la Lock Academy, vous avez du aussi remarquer cette inspiration anglo-saxonne dans les décors, les motifs, … Cette influence n’a pas été reniée dans ce jeu. Vous aurez la possibilité de voir rejaillir cette ambiance so british lors de votre progression. Mais là ce sera à vous de le découvrir par vous même !",
# address: "25 Rue Coquillière, 75001 Paris",
# phone_number: "01 01 01 01 01",
# min_players: 2,
# max_players: 5,
# price_per_hour: 45)

# b = Booking.create!(user: User.last, game: Game.first, starts_at: Time.now, duration: 1, nb_players: 4)


require 'open-uri'
require 'nokogiri'
require 'faker'

#http://www.topito.com/top-live-escape-game-paris-france

# html_file = open("http://www.topito.com/top-live-escape-game-paris-france")
html_file = File.read('./db/seed_webpage.html')
html_doc = Nokogiri::HTML(html_file)

games = []

count = 0
html_doc.search('li > strong > a').each do |element|
  puts count += 1
  escape_game_name = element.text
  $my_li = element.parent.parent
  escape_game_address = $my_li.search('u').first.next.text.strip.gsub(": ","")

  if $my_li
    if $my_li.search('figure > a > img').size > 0
      escape_game_image_url = $my_li.search('figure > a > img').attr('src').text
    else
      escape_game_image_url = ""
    end
    escape_game_phone_number = Faker::PhoneNumber.cell_phone
    escape_game_min_player = (2..4).to_a.sample
    escape_game_max_player = (4..7).to_a.sample
    escape_game_price_per_hour = (35..60).to_a.sample

    if $my_li.search('u').count > 1
      ambiance_text = $my_li.search('u').first.next.next.text.strip.gsub("Ambiance : ","").capitalize
      if ambiance_text != ""
        les_plus_text = $my_li.search('u').first.next.next.next.next.text.strip.gsub("Le plus : ", "").capitalize.gsub(" topito", "")
        escape_game_description =  ambiance_text + les_plus_text
      else
        escape_game_description = "missing"
      end
    else
      escape_game_description = "missing"
    end
    my_game = Game.create(
      name: escape_game_name,
      description: escape_game_description,
      address: escape_game_address,
      min_players: escape_game_min_player,
      max_players: escape_game_max_player,
      price_per_hour: escape_game_price_per_hour,
      phone_number: escape_game_phone_number,
      )
    my_game.photo_url = escape_game_image_url unless escape_game_image_url == ""
    my_game.user = User.create(
    email: Faker::Internet.email,
    password: "aaaaaaaa",
    phone_number: Faker::PhoneNumber.cell_phone,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    )
    my_game.save!
  end
end
