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
    games << Game.new(
      name: escape_game_name,
      description: escape_game_description + escape_game_image_url,
      address: escape_game_address,
      min_players: escape_game_min_player,
      max_players: escape_game_max_player,
      price_per_hour: escape_game_price_per_hour,
      phone_number: escape_game_phone_number,
      photo_url: escape_game_image_url
      )
  end
end

