# frozen_string_literal: true

namespace :recipes do
  desc 'Import recipes from a JSON file'
  task :import, [:file] => :environment do |_t, args|
    file_path = args[:file] || 'lib/recipes-en.json'

    # Ensure the file exists before proceeding
    unless File.exist?(file_path)
      puts "File not found: #{file_path}"
      exit
    end

    # Read the JSON file
    file_content = File.read(file_path)

    begin
      recipes_data = JSON.parse(file_content)
    rescue JSON::ParserError => e
      puts "There was an error parsing the JSON file: #{e.message}"
      exit
    end

    # Iterate through each recipe and create it in the database
    recipes_data.each do |recipe_data|
      author = Author.find_or_create_by!(name: recipe_data['author']) if recipe_data['author'].present?
      category = Category.find_or_create_by!(name: recipe_data['category']) if recipe_data['category'].present?
      cuisine = Cuisine.find_or_create_by!(name: recipe_data['cuisine']) if recipe_data['cuisine'].present?

      recipe = Recipe.new(
        title: recipe_data['title'],
        author_id: author&.id,
        category_id: category&.id,
        cuisine_id: cuisine&.id,
        cook_time: recipe_data['cook_time'],
        prep_time: recipe_data['prep_time'],
        ratings: recipe_data['ratings'],
        image_url: recipe_data['image'],
        ingredients: recipe_data['ingredients']
      )

      # binding.pry
      recipe.save!
    end

    puts "Finished importing recipes from #{file_path}"
  end
end
