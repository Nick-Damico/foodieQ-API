class AddColumnPublishedToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :published, :boolean, default: false
  end
end
