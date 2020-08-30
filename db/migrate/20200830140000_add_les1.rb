class AddLes1 < ActiveRecord::Migration[6.0]
  def up
    # setup
    this_user = User.find_by_name("Marta Dijkhoff") || User.first

    # add new wordtypes
    [ 'pronòmber demostrativo',
      'pronòmber interogativo',
      'pronómber personal/posesivo' ].each do |wordtype|
        Wordtype.find_by_name(wordtype) || Wordtype.create(name: wordtype)
    end

    csv_file = "#{Rails.root}/stuff/Words A1 - Lesson 1.csv"
    raise "csv file bestaat niet: #{csv_file}" unless File.exists? csv_file

    source = Source.find_by_name('Dijkhoff Les 1')
    source ||= Source.create(name: 'Dijkhoff Les 1', comment: 'Dijkhoff Les 1')

    require 'csv'
    csv = CSV.parse(File.read(csv_file), :col_sep => ";", headers: true, converters: lambda { |h| h && h.downcase })

    # part 1: create words or add attributes to existing words
    # "word";"wordtype";"L";"varianten";"context";"english";"spanish"
    csv.each do |row|
      word = Word.find_by_name(row["word"])
      if word.nil?
        word = Word.create( name: row["word"],
                            wordtypes: [Wordtype.find_by_name(MARTA_WOORDTYPES[row["wordtype"]])],
                            varianten: row["varianten"],
                            context: row["context"],
                            tr_en: row["english"],
                            tr_es: row["spanish"],
                            sources: [source],
                            user: this_user,
                          )
        puts "Created #{word.name}"
      else
        word.tr_en = row["english"]
        word.tr_es = row["spanish"]
        word.sources << source
        word.varianten = row["varianten"]
        word.context = row["context"]
        word.wordtypes = [word.wordtypes, Wordtype.find_by_name(MARTA_WOORDTYPES[row["wordtype"]])].flatten.uniq
        word.save
        puts "Updated #{word.name}"
      end
    end

  end
end
