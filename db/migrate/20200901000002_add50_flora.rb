class Add50Flora < ActiveRecord::Migration[6.0]
  def up
    # setup
    wordtype = Wordtype.find_by_name('sustantivo')
    this_user = User.find_by_name('Open Content for Education') || User.first

    csv_file = '/tmp/Flora50.csv'
    raise "csv file bestaat niet: #{csv_file}" unless File.exists? csv_file

    photo_dir = '/tmp/flora50'
    raise "photo_dir bestaat niet: #{photo_dir}" unless File.directory? photo_dir

    source = Source.find_by_name('Open Content for Education 2020')
    source ||= Source.create(name: 'Open Content for Education 2020', comment: 'Open Content for Education 2020, sponsored by Prins Bernhard Cultuurfonds Caribisch Gebied')

    require 'csv'
    csv = CSV.parse(File.read(csv_file), headers: true, converters: lambda { |h| h && h.downcase })
    # pap_cw	nl	en	scientific	image

    # part 1: create words or add attributes to existing words
    csv.each do |row|
      word = Word.find_by_name(row["pap_cw"])
      if word.nil?
        word = Word.create( name: row["pap_cw"],
                            tr_en: row["en"],
                            tr_nl: row["nl"],
                            tr_pap_cw: row["pap_cw"],
                            scientific_name: row["scientific"],
                            sources: [source],
                            wordtypes: [wordtype],
                            is_flora: 2,
                            user: this_user,
                            countable: 1,
                          )
      else
        word.tr_en = row["en"]
        word.tr_nl = row["nl"]
        word.tr_pap_cw = row["pap_cw"]
        word.scientific_name = row["scientific"]
        word.sources << source
        word.is_flora = 2
        word.save
      end
    end

    # part 2: add photos
    this_user = User.find_by_name('Michelle Pors-da Costa Gomez') || User.first

    csv.each do |row|
      word = Word.find_by_name(row["pap_cw"])
      if word.nil?
        raise "This should not happen/ #{row["pap_cw"]} should exist!"
      else
        image_filename = row["image"]
        unless image_filename && File.exists?("#{photo_dir}/#{image_filename}")
          puts "The word #{row["pap_cw"]} has no image..."
        else
          picture = word.pictures.create( name: row["pap_cw"],
                                caption: row["pap_cw"],
                                description: row["pap_cw"],
                                user: this_user,
                              )
          # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-%22Upload%22-from-a-local-file
          picture.image = Pathname.new("#{photo_dir}/#{image_filename}").open
          picture.save!
        end
      end
    end
  end
end
