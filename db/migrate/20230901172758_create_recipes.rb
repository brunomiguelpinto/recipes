class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title, required: true
      t.references :author, index: true, required: false
      t.references :category, index: true, required: false
      t.references :cuisine, index: true, required: false
      t.integer :cook_time
      t.integer :prep_time
      t.float :ratings
      t.string :image_url
      t.text :ingredients
      t.timestamps
    end
  end
end
