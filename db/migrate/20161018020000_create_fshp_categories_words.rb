class CreateFshpCategoriesWords < ActiveRecord::Migration

  def self.up
    create_table "fshp_categories_words", :id => false, :force => true do |t|
      t.integer "fshp_category_id"
      t.integer "word_id"
    end
  end

  def self.down
    drop_table "fshp_categories_words"
  end

end
