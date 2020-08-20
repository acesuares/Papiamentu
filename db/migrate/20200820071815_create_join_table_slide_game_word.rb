class CreateJoinTableSlideGameWord < ActiveRecord::Migration[6.0]
  def change
    create_join_table :slide_games, :words do |t|
      t.index [:slide_game_id, :word_id]
      t.index [:word_id, :slide_game_id]
    end
  end
end
