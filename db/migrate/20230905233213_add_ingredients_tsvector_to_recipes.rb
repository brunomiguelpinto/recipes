class AddIngredientsTsvectorToRecipes < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE recipes ADD COLUMN ingredients_tsvector tsvector 
          GENERATED ALWAYS AS (to_tsvector('english', ingredients)) STORED;
    SQL

    add_index :recipes, :ingredients_tsvector, using: :gin
  end

  def down
    remove_index :recipes, :ingredients_tsvector
    remove_column :recipes, :ingredients_tsvector
  end
end
