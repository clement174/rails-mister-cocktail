# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

ingredients_json = open('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read
ingredients = JSON.parse(ingredients_json)
puts 'start'
ingredients['drinks'].each do |ingredient|
  ingredient_name = ingredient['strIngredient1']
  Ingredient.create(name: ingredient_name)
end
puts 'end'

cocktail_1 = Cocktail.create(name: "Whisky coca")
cocktail_2 = Cocktail.create(name: "Gin tonic")

dose_1 = Dose.new(description: "5cl")
dose_2 = Dose.new(description: "7cl")
dose_3 = Dose.new(description: "10cl")

ingredient_1 = Ingredient.find(490)
ingredient_2 = Ingredient.find(491)
ingredient_3 = Ingredient.find(492)

dose_1.ingredient = ingredient_1
dose_2.ingredient = ingredient_2
dose_3.ingredient = ingredient_3

dose_1.cocktail = cocktail_1
dose_2.cocktail = cocktail_1
dose_3.cocktail = cocktail_2

dose_1.save
dose_2.save
dose_3.save

