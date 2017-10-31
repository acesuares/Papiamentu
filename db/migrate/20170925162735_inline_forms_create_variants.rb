class InlineFormsCreateVariants < ActiveRecord::Migration[5.0]
  def self.up
    create_table :variants do |t|
      t.string :lemma
      t.string :orthographic_type
      t.belongs_to :word
      t.timestamps
    end

    # Adding 'cw' variants
    Word.all.each do |word|
      word.variants.create(lemma: word.name.strip, orthographic_type: 'cw')
    end

    # Adding 'aw' variants and setting the universal ones 'pap'
    aw_variants_file = File.join Rails.root, 'stuff/aw_variants.csv'
    File.open(aw_variants_file, 'r').each_line do |line|
      line = line.strip
      cw_lemma, aw_lemma = line.split ','
      # Go to the next row if Aruba variant is empty
      next if aw_lemma == 'x'

      # Search the Curacao variant in the databaase
      variants = Variant.where(lemma: cw_lemma)

      next if variants.empty?

      variants.each do |variant|
        if variant.lemma == aw_lemma
          # If the variants are equal, set the existing one as "pap"
          # "pap" means universal across papiamentu orthographies
          variant.orthographic_type = 'pap'
          variant.save
        elsif Variant.where(lemma: aw_lemma, word_id: variant.word.id).empty?
          # If the variants are different and
          # it is not already in the database attached
          # with th cw variant in this loop iteration
          # then, create the new one with Aruba orthography
          variant.word.variants.create(
            lemma: aw_lemma,
            orthographic_type: 'aw'
          )
        end
      end
    end
  end

  def self.down
    drop_table :variants
  end
end
