class AddKimikaToWords < ActiveRecord::Migration[6.0]
  def up
    add_column :words, :atoomnummer, :integer, default: 0
    add_column :words, :tr_nl_variant, :string
    add_column :words, :symbool, :string
    add_column :words, :is_element, :integer, default: 1

    Word.reset_column_information

    # setup
    this_user = User.find_by_name("Gertrude Franca") || User.first

    csv_file = "#{Rails.root}/stuff/Kimika.csv"
    raise "csv file bestaat niet: #{csv_file}" unless File.exists? csv_file

    source = Source.find_by_name('Lijst van Elementen')
    source ||= Source.create(name: 'Lijst van Elementen', comment: 'Lijst van Elementen, Gertrude Franca e.a., 2019')

    wordtype = Wordtype.find_by_name('sustantivo')

    require 'csv'
    csv = CSV.parse(File.read(csv_file), :col_sep => ";", headers: true)

    # part 1: create words or add attributes to existing words
    # "atoomnummer";"symbool";"tr_nl";"nl_variant";"tr_pap_cw";"pap_cw_variant";"tr_en";"tr_es"

    csv.each do |row|
      word = Word.find_by_name(row["tr_pap_cw"])
      if word.nil?
        word = Word.create( name: row["tr_pap_cw"],
                            atoomnummer: row["atoomnummer"],
                            symbool: row["symbool"],
                            tr_nl: row["tr_nl"],
                            tr_es: row["tr_es"],
                            tr_en: row["tr_en"],
                            tr_nl_variant: row["nl_variant"],
                            tr_pap_cw: row["tr_pap_cw"],
                            varianten: row["pap_cw_variant"],
                            is_element: 2,
                            wordtypes: [wordtype],
                            sources: [source],
                            user: this_user,
                          )
        puts "Created #{word.name}"
      else
        word.atoomnummer = row["atoomnummer"]
        word.symbool = row["symbool"]
        word.tr_nl = row["tr_nl"]
        word.tr_nl_variant = row["nl_variant"]
        word.tr_pap_cw = row["tr_pap_cw"]
        word.tr_es = row["tr_es"]
        word.tr_en = row["tr_en"]
        word.varianten = word.varianten.blank? ? row["pap_cw_variant"] : "#{word.varianten}, #{row['pap_cw_variant']}"
        word.is_element = 2
        word.wordtypes = [word.wordtypes, wordtype].flatten.uniq
        word.sources = [word.sources, source].flatten.uniq
        word.save
        puts "Updated #{word.name}"
      end
    end


  end
end
