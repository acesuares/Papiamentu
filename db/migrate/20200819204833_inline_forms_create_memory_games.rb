class InlineFormsCreateMemoryGames < ActiveRecord::Migration[5.0]

  def self.up
    create_table :memory_games do |t|
      t.string :name 
      t.belongs_to :user 
      t.timestamps
    end
  end

  def self.down
    drop_table :memory_games
  end

end
