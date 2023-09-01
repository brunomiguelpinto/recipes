class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.integer :cook_time
      t.integer :prep_time

      t.timestamps
    end
  end
end
