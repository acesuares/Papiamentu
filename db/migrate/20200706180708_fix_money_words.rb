class FixMoneyWords < ActiveRecord::Migration[6.0]
  def up
    wordtype = Wordtype.find_by_name('sustantivo')
    this_user = User.find_by_name('Richenel Ansano')

    Word.where(is_money: 2).each do |word|
      word.wordtypes = [wordtype]
      word.user = this_user
      word.save
    end
  end

end
