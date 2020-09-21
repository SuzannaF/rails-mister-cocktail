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

image_index = ["https://res.cloudinary.com/dq9sg8kv9/image/upload/v1600714844/photo-1541807120430-f3f78c281225_c74lab.jpg", "https://res.cloudinary.com/dq9sg8kv9/image/upload/v1600714844/photo-1542849187-5ec6ea5e6a27_qpnlwg.jpg", "https://res.cloudinary.com/dq9sg8kv9/image/upload/v1600714842/photo-1559164767-bc9449f7ebd6_bcd029.jpg", "https://res.cloudinary.com/dq9sg8kv9/image/upload/v1600714842/photo-1547383529-2b2374860dc8_g7ok1v.jpg", "https://res.cloudinary.com/dq9sg8kv9/image/upload/v1600714842/photo-1536935338788-846bb9981813_zfancy.jpg", "https://res.cloudinary.com/dq9sg8kv9/image/upload/v1600714842/photo-1527628126150-086ff233b951_hff26e.jpg", "https://res.cloudinary.com/dq9sg8kv9/image/upload/v1600714842/photo-1547383529-2b2374860dc8_g7ok1v.jpg"]

6.times do
  file = URI.open(image_index.shuffle!.pop)
  cocktail = Cocktail.new(
    name: Faker::Dessert.flavor
  )
  cocktail.photo.attach(io: file, filename: 'cocktail.jpg', content_type: 'image/jpg')
  cocktail.save
end

puts "Finished"

###### DESCRIPTIONS
# A Whiskey Sour made with Bourbon Whiskey and Lemon Juice, yet garnished with a lime
# The Fairytale Negroni is a composition of gin, bitter liqueur and vermouth, just like the classic Negroni cocktail
