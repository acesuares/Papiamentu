class CreateGlossariesWords < ActiveRecord::Migration[5.1]
  def self.up
    create_table :glossaries_words, id: false do |t|
      t.belongs_to :word, index: true
      t.belongs_to :glossary, index: true
    end
  end

  def self.down
    drop_table :glossaries_words
  end
end
