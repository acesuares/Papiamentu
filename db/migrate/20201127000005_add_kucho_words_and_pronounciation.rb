class AddKuchoWordsAndPronounciation < ActiveRecord::Migration[6.0]
  def up
    # setup
    this_user = User.find_by_name('Laura Quast') || User.first
    wordtype = Wordtype.find_by_name('sustantivo')
    source = Source.find_by_name('Kucho di Otrobanda')
    source ||= Source.create(name: 'Kucho di Otrobanda', comment: 'Kucho di Otrobanda, https://kuchodiotrobanda.com')

    mp3_dir = '/tmp/mp3_kucho'
    raise "mp3_dir bestaat niet: #{mp3_dir}" unless File.directory? mp3_dir

    Dir["#{mp3_dir}/*.mp3"].each do |filename|
      search_word = filename.gsub("#{mp3_dir}/",'').gsub(/\.mp3/,'')
      word = Word.find_by_name(search_word)
      if word.nil?
        word = Word.create( name: search_word,
                            tr_pap_cw: search_word,
                            sources: [source],
                            wordtypes: [wordtype],
                            user: this_user,
                          )
        puts "C: created word: #{word.name}"
      end

      recording = word.recordings.create( name: search_word, user: this_user )
      recording.audio = Pathname.new(filename).open
      recording.save!
      puts "R: added recording to #{word.name}"
    end
  end
end
