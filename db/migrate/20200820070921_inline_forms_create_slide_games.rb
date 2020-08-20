class InlineFormsCreateSlideGames < ActiveRecord::Migration[5.0]

  def self.up
    create_table :slide_games do |t|
      t.string :name 
      t.string :title 
      t.text :description 
      t.belongs_to :user 
      t.timestamps
    end
  end

  def self.down
    drop_table :slide_games
  end

end
