class CreateSpellingSessions < ActiveRecord::Migration[5.1]
  def self.up
    create_table :spelling_sessions do |t|
      t.belongs_to :user, index: true

      t.timestamps
    end
  end

  def self.down
    drop_table :spelling_sessions
  end
end
