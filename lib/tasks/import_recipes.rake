namespace :recipes do
  desc "Import recipes from a JSON file"
  task :import, [:file] => :environment do |t, args|
    file_path = args[:file] || "lib/recipes-en.json"

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
      recipe = Recipe.create!(
        title: recipe_data["title"],
      )
    end

    puts "Finished importing recipes from #{file_path}"
  end
end
