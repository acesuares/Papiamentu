class CreateSourcesWords < ActiveRecord::Migration

  def self.up
    create_table "sources_words", :id => false, :force => true do |t|
      t.integer "source_id"
      t.integer "word_id"
    end
    Word.reset_column_information
    Word.all.each do |word|
        word.sources << word.source
    end
  end

  def self.down
    drop_table "sources_words"
  end

end
