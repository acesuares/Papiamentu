class CreateWordsGoals < ActiveRecord::Migration

  def self.up
 create_table "goals_words", :id => false, :force => true do |t|
     t.integer "goal_id"
         t.integer "word_id"
           end
end           

  def self.down
    drop_table "goals_words"
  end

end
