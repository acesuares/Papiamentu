class CreateWordsWordtypes < ActiveRecord::Migration

  def self.up
  create_table "words_wordtypes", :id => false, :force => true do |t|
      t.integer "word_id"
          t.integer "wordtype_id"
            end
  end

  def self.down
    drop_table "words_wordtypes"
  end

end
