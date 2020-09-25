# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'faker'

######### INGREDIENTS

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

serialized_ingredients = open(url).read

@ingredients = JSON.parse(serialized_ingredients)

@ingredients['drinks'].each do |ingredient|
  ingredient.each_value do |value|
    ing = Ingredient.new
    ing.name = value
    ing.save
  end
end

######### COCKTAILS

puts "Creating cocktails"

image_index = [
  'https://res.cloudinary.com/dq9sg8kv9/image/upload/v1601043963/photo-1527271982979-83fea3eb3582_p5mgtw.jpg',
  'https://res.cloudinary.com/dq9sg8kv9/image/upload/v1601043964/photo-1532117182044-031e7cd916ee_powrqj.jpg',
  'https://res.cloudinary.com/dq9sg8kv9/image/upload/v1601043966/photo-1595981267035-7b04ca84a82d_eywbjj.jpg',
  'https://res.cloudinary.com/dq9sg8kv9/image/upload/v1601043966/photo-1560508179-b2c9a3f8e92b_cllpkl.jpg',
  'https://res.cloudinary.com/dq9sg8kv9/image/upload/v1601043968/photo-1560508180-03f285f67ded_m1vivh.jpg',
  'https://res.cloudinary.com/dq9sg8kv9/image/upload/v1601043968/photo-1497534446932-c925b458314e_nali6g.jpg'
]

6.times do
  file = URI.open(image_index.shuffle!.pop)
  cocktail = Cocktail.new(
    name: [
      'Pink Fantasy',
      'Pink Panther',
      'Fizzy Fluff',
      'Cotton Candy Clash',
      'Sparkly Dahlia',
      'Prickly Rose Thorn'
    ].shuffle!.pop
  )

  cocktail.photo.attach(io: file, filename: 'cocktail.jpg', content_type: 'image/jpg')
  cocktail.save

######### DOSES

  dose = Dose.new(
    description: [
      '1 Bunch',
      '2 Knuckles',
      '3 Fists',
      '4 Sprinkles',
      '5 Pieces',
      '6 Gulps'
    ].shuffle!.pop,
    cocktail: cocktail,
  )
  dose.save
end

puts "Finished"

###### DESCRIPTIONS
# A Whiskey Sour made with Bourbon Whiskey and Lemon Juice, yet garnished with a lime
# The Fairytale Negroni is a composition of gin, bitter liqueur and vermouth, just like the classic Negroni cocktail
