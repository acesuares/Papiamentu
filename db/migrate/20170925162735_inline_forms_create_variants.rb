class InlineFormsCreateVariants < ActiveRecord::Migration
  def self.up
    create_table :variants, :id => true do |t|
      t.string :lemma
      t.string :orthographic_type
      t.belongs_to :word
      t.timestamps
    end

    Word.all.each do |word|
      word.variants.create(lemma: word.name.strip, orthographic_type: 'cw')
    end
  end

  def self.down
    drop_table :variants
  end
end
