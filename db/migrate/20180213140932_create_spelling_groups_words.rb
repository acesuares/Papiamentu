class CreateSpellingGroupsWords < ActiveRecord::Migration[5.1]
  def self.up
    create_table :spelling_groups_words, id: false do |t|
      t.belongs_to :word, index: true
      t.belongs_to :spelling_group, index: true
    end
  end

  def self.down
    drop_table :spelling_groups_words
  end
end
