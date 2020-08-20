class CreateJoinTableMemoryGameWord < ActiveRecord::Migration[6.0]
  def change
    create_join_table :memory_games, :words do |t|
      t.index [:memory_game_id, :word_id]
      t.index [:word_id, :memory_game_id]
    end
  end
end
