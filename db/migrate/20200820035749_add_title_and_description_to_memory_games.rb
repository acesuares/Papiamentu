class AddTitleAndDescriptionToMemoryGames < ActiveRecord::Migration[6.0]
  def change
    add_column :memory_games, :title, :string
    add_column :memory_games, :description, :text
  end
end
