require 'csv'

namespace :variants do
  desc 'Importá e variantenan segun ortografia di Aruba'
  task import: :environment do
    file = File.join Rails.root, ENV['FILENAME']
    counter = 0
    CSV.foreach(file, headers: true) do |row|
      # Go to the next row if Aruba variant is empty
      next if row['pap_aw'].strip == 'x'

      cw_lemma = row['pap_cw'].strip

      # Search the Curacao variant in the databaase
      variant = Variant.find_by_lemma(cw_lemma)

      if variant.nil?
        puts "#{cw_lemma}; Not found"
      elsif variant.lemma == row['pap_aw'].strip
        # If the variants are equal, set the existing one as "pap"
        # "pap" means universal across papiamentu orthographies
        variant.orthographic_type = 'pap'
        variant.save
      else
        # If the variants are different
        # create the new one with Aruba orthography
        variant.word.variants.create(
          lemma: row['pap_aw'].strip,
          orthographic_type: 'aw'
        )
        counter += 1
      end
    end

    puts "#{counter} palabra a wòrdu importá"
  end
end
