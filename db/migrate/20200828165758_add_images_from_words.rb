class AddImagesFromWords < ActiveRecord::Migration[6.0]
  def change
    # copy the name to tr_pap_cw
    Word.has_pictures.each{|word|word.update_attribute(:tr_pap_cw, word.name)}
    # create pictures from words
    Word.has_pictures.each{|word|word.image_from_word(:tr_pap_cw)}
  end
end
