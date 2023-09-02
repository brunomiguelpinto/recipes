class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.references :author, index: true
      t.references :category, index: true
      t.references :cuisine, index: true, required: false

      t.timestamps
    end
  end
end
