class AddNederlandsBouwwoorden < ActiveRecord::Migration[6.0]
  csv_file = '/tmp/NLbouwwoorden.csv'
  raise "csv file bestaat niet: #{csv_file}" unless File.exists? csv_file

  require 'csv'
  csv = CSV.parse(File.read(csv_file), col_sep:";", row_sep:"\n", quote_char:"\"", headers: true)
  # nederlands	papiamentu foto
  csv.each do |row|
    # puts row.inspect
    foto_word = row["foto"].downcase.gsub("_", " ")
    word = Word.find_by_name(foto_word)
    if word.nil?
      puts "#{foto_word} not found"
    else
      puts "Updated #{foto_word}..."
      nl_db = word.tr_nl.split(/, */) rescue []
      nl_file = row["nederlands"].downcase.split(/, */)
      nl = (nl_db + nl_file).flatten.compact.uniq.join(", ")
      word.tr_nl = nl
      puts "...nl: #{nl}..."
      varianten_db = word.varianten.split(/, */) rescue []
      varianten_file = row["papiamentu"].downcase.split(/, */)
      varianten = ((varianten_db + varianten_file).flatten.compact.uniq - [foto_word]).join(", ")
      word.varianten = varianten
      puts "...varianten: #{varianten}..."
      word.save
    end
  end
end
