class CleanSpacesAndParenthesisFromWords < ActiveRecord::Migration
  def up
    Word.where('buki_di_oro <> 1').each do |word|
      cleaned_word = word.name.gsub(/[()]/, '').squish.downcase
      word.update_column(:name, cleaned_word) unless word.name == cleaned_word
    end
  end

  def down
  end
end
