class CreateSpellingTries < ActiveRecord::Migration[5.1]
  def self.up
    create_table :spelling_tries do |t|
      t.string :user_input
      t.boolean :correct
      t.integer :points
      t.belongs_to :spelling_session, index: true
      t.belongs_to :word, index: true

      t.timestamps
    end
  end

  def self.down
    drop_table :spelling_tries
  end
end
