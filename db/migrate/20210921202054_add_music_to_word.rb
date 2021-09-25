class AddMusicToWord < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :is_music, :integer, default: 1
  end
end
